import { fileExists, readFileContent, writeToFile } from './file';
import { Standard, StandardOverview, UpdateDetails } from './types';
import { getChecksum } from './checksum';
import { getDetails } from './search';
import { artifactsFolder, getEnumKeyByValue } from './utils';

// Returns true if any codelist file listed in a version's codelists.json is absent on disk.
// Used to restore locally deleted files even when the API checksum hasn't changed.
async function hasMissingFiles(standard: Standard, details: StandardOverview): Promise<boolean> {
  const rootFolder = `${artifactsFolder}/${getEnumKeyByValue(Standard, standard)}`;
  for (const version of details.versionen) {
    const checklistPath = `${rootFolder}/${version.version}/codelists.json`;
    if (!fileExists(checklistPath)) continue;
    const content = await readFileContent(checklistPath);
    if (!content) continue;
    try {
      const codelists: string[] = JSON.parse(content);
      for (const cl of codelists) {
        if (!fileExists(`${artifactsFolder}/codelists/${cl}`)) {
          console.log(`Missing artifact detected: ${cl} — triggering update.`);
          return true;
        }
      }
    } catch {
      // ignore malformed codelists.json
    }
  }
  return false;
}

export async function checkForUpdates(standard: Standard): Promise<UpdateDetails> {
  try {
    const standardDetails = await getDetails(standard);
    const checksum = await getChecksum(standardDetails);
    const checksumFile = `${artifactsFolder}/${getEnumKeyByValue(Standard, standard)}/checksum.md5`;
    const exists = fileExists(checksumFile);
    const details: UpdateDetails = {
      updated: standardDetails.updated,
      updateDetected: true,
      details: standardDetails,
      checksum,
    };
    if (exists) {
      const currentChecksum = await readFileContent(checksumFile);
      if (currentChecksum?.trim() === checksum) {
        const missing = await hasMissingFiles(standard, standardDetails);
        if (!missing) {
          details.updateDetected = false;
        }
      }
    }
    return details;
  } catch (err) {
    console.error('Failed to check for updates:', err);
    throw err;
  }
}

export async function update(
  standard: Standard,
  updateChecksum: boolean = false
): Promise<UpdateDetails> {
  const result = await checkForUpdates(standard);
  const checksumFile = `${artifactsFolder}/${getEnumKeyByValue(Standard, standard)}/checksum.md5`;
  if (result.updateDetected && updateChecksum) {
    try {
      await writeToFile(checksumFile, result.checksum);
      console.log(`Checksum for ${standard} updated successfully (Date: ${result.updated}).`);
    } catch (error) {
      console.error(`Failed to update checksum for ${standard}:`, error);
    }
  } else if (!result.updateDetected) {
    console.log(`Checksum for ${standard} is already up to date.`);
  }
  return result;
}

