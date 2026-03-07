import { fileExists, readFileContent, writeToFile } from './file';
import { Standard, UpdateDetails } from './types';
import { getChecksum } from './checksum';
import { getDetails } from './search';
import { artifactsFolder, getEnumKeyByValue } from './utils';

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
      if (currentChecksum === checksum) {
        details.updateDetected = false;
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

