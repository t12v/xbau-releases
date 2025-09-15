import { readFile, writeFile } from 'fs/promises';
import { existsSync, mkdirSync } from 'fs';
import { dirname } from 'path';

function ensureDirExists(filePath: string) {
  const dir = dirname(filePath);
  mkdirSync(dir, { recursive: true });
}
export function fileExists(path: string): boolean {
  try {
    return existsSync(path);
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
    console.debug('File written successfully. ' + file);
  } catch (err) {
    console.error('Error writing file:', err);
  }
}
