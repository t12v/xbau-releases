import { fileExists, readFileContent, writeToFile } from './file';
import { Standard } from './types';
import { getChecksum } from './checksum';

export async function update(standard: Standard, updateChecksum: boolean = false): Promise<boolean> {
  const checksum = await getChecksum(standard);
  const checksumFile = standard + '.md5';
  const exists = await fileExists(checksumFile);
  if (!exists) {
    try {
      await writeToFile(checksumFile, checksum);
      console.log(`Checksum for ${standard} updated successfully.`);
      return true;
    } catch (error) {
      console.error(`Failed to update checksum for ${standard}:`, error);
      return false;
    }
  }
  const currentChecksum = await readFileContent(checksumFile);
  if (currentChecksum === checksum) {
    console.log(`Checksum for ${standard} is already up to date.`);
    return false;
  }
  if (updateChecksum) {
    try {
      await writeToFile(checksumFile, checksum);
      console.log(`Checksum for ${standard} updated successfully.`);
    } catch (error) {
      console.error(`Failed to update checksum for ${standard}:`, error);
    }
  }
  return true;
}
