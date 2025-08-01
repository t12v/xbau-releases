import { access, readFile, writeFile } from 'fs/promises';
import { constants } from 'fs';
import { Standard } from './types';
import { getChecksum } from './checksum';
async function fileExists(path: string): Promise<boolean> {
  try {
    await access(path, constants.F_OK);
    return true;
  } catch {
    return false;
  }
}

export async function readFileContent(path: string): Promise<string | null> {
  try {
    const content = await readFile(path, 'utf-8');
    return content;
  } catch (err) {
    console.error(`Failed to read file at ${path}:`, err);
    return null;
  }
}

async function writeToFile(file: string, content: string): Promise<void> {
  try {
    await writeFile(file, content, 'utf-8');
    console.log('File written successfully.');
  } catch (err) {
    console.error('Error writing file:', err);
  }
}

export async function update(standard: Standard, updateChecksum:boolean = false): Promise<boolean> {
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
  if (updateChecksum){
    try {
      await writeToFile(checksumFile, checksum);
      console.log(`Checksum for ${standard} updated successfully.`);
    } catch (error) {
      console.error(`Failed to update checksum for ${standard}:`, error);
    }
  }
  return true;
}
