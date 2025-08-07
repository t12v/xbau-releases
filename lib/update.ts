import { fileExists, readFileContent, writeToFile } from './file';
import { Standard, UpdateDetails } from './types';
import { getChecksum } from './checksum';
import { getDetails } from './search';
import { getEnumKeyByValue } from './utils';

export async function checkForUpdates(standard: Standard): Promise<UpdateDetails> {
  const standardDetails = await getDetails(standard);
  const checksum = await getChecksum(standardDetails);
  const checksumFile = getEnumKeyByValue(Standard, standard) + '/checksum.md5';
  const exists = await fileExists(checksumFile);
  const details: UpdateDetails = {
    updated: standardDetails.updated,
    updateDetected: true,
    checksum,
  };
  if (!exists) {
    try {
      details.updateDetected = true;
    } catch (error) {
      details.updateDetected = false;
      console.error('Error during update check', error)
    }
  }
  const currentChecksum = await readFileContent(checksumFile);
  if (currentChecksum === checksum) {
    details.updateDetected = false;
  }
  return details;
}

export async function update(standard: Standard, updateChecksum: boolean = false): Promise<boolean> {
  const update = await checkForUpdates(standard);
  const checksumFile = getEnumKeyByValue(Standard, standard) + '/checksum.md5';
  if (update.updateDetected) {
    if (updateChecksum) {
      try {
        await writeToFile(checksumFile, update.checksum);
        console.log(`Checksum for ${standard} updated successfully (Date: ${update.updated}).`);
        return true;
      } catch (error) {
        console.error(`Failed to update checksum for ${standard}:`, error);
      }
    }
  } else {
    console.log(`Checksum for ${standard} is already up to date.`);
  }
  return false;
}
