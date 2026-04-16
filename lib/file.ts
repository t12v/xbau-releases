import { readFile, readdir, writeFile } from 'fs/promises';
import { createReadStream, existsSync, mkdirSync, readFileSync } from 'fs';
import { dirname, join } from 'path';
import unzipper from 'unzipper';

export function ensureDirExists(filePath: string): void {
  const dir = dirname(filePath);
  mkdirSync(dir, { recursive: true });
}

export async function listFiles(rootDir: string): Promise<string[]> {
  const entries = await readdir(rootDir, { withFileTypes: true });
  // Only keep files (ignore directories)
  return entries.filter((entry) => entry.isFile()).map((entry) => join(rootDir, entry.name));
}

export async function unzipFile(zipFilePath: string, outputFolder: string): Promise<void> {
  // Ensure the output folder exists
  mkdirSync(outputFolder, { recursive: true });

  // Check first 4 bytes
  const fileBytes = readFileSync(zipFilePath).slice(0, 4);
  if (fileBytes[0] !== 0x50 || fileBytes[1] !== 0x4b) {
    throw new Error('Downloaded file is not a valid ZIP');
  }

  return new Promise<void>((resolve, reject) => {
    createReadStream(zipFilePath)
      .pipe(unzipper.Extract({ path: outputFolder }))
      .on('close', () => {
        console.log(`Extraction complete: ${outputFolder}`);
        resolve();
      })
      .on('error', (err) => {
        reject(new Error(`Failed to extract ZIP: ${err.message}`));
      });
  });
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

export async function writeToFile(file: string, content: string | ArrayBuffer): Promise<void> {
  try {
    ensureDirExists(file);
    await writeFile(file, content instanceof ArrayBuffer ? new Uint8Array(content) : content);
    console.debug('File written successfully. ' + file);
  } catch (err) {
    console.error('Error writing file:', err);
  }
}
