import { access, readFile, writeFile } from 'fs/promises';
import { constants, mkdirSync } from 'fs';
import { dirname } from 'path';

function ensureDirExists(filePath: string) {
  const dir = dirname(filePath);
  mkdirSync(dir, { recursive: true });
}
export async function fileExists(path: string): Promise<boolean> {
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

export async function writeToFile(file: string, content: string): Promise<void> {
  try {
    ensureDirExists(file);
    await writeFile(file, content, 'utf-8');
    console.log('File written successfully.');
  } catch (err) {
    console.error('Error writing file:', err);
  }
}
