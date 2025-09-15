import { fileExists, readFileContent, writeToFile } from './file';
import { Standard, UpdateDetails } from './types';
import { getChecksum } from './checksum';
import { getDetails } from './search';
import { artifactsFolder, getEnumKeyByValue } from './utils';

export async function checkForUpdates(standard: Standard): Promise<UpdateDetails> {
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
  if (!exists) {
    try {
      details.updateDetected = true;
    } catch (error) {
      details.updateDetected = false;
      console.error('Error during update check', error);
    }
  }
  const currentChecksum = await readFileContent(checksumFile);
  if (currentChecksum === checksum) {
    details.updateDetected = false;
  }
  return details;
}

export async function update(standard: Standard, updateChecksum: boolean = false): Promise<UpdateDetails> {
  const result = await checkForUpdates(standard);
  const checksumFile = `${artifactsFolder}/${getEnumKeyByValue(Standard, standard)}/checksum.md5`;
  if (result.updateDetected) {
    if (updateChecksum) {
      try {
        await writeToFile(checksumFile, result.checksum);
        console.log(`Checksum for ${standard} updated successfully (Date: ${result.updated}).`);
      } catch (error) {
        console.error(`Failed to update checksum for ${standard}:`, error);
      }
    }
  } else {
    console.log(`Checksum for ${standard} is already up to date.`);
  }
  return result;
}
