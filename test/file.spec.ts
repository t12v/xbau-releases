/// <reference types="jest-extended" />
import { fileExists, readFileContent } from '../lib/file';
const SECONDS = 10;
jest.setTimeout(1000 * SECONDS);

test('file exists', async () => {
  expect(await fileExists('./test/file.spec.ts')).toBeTrue();
});

test('file does not exist', async () => {
  expect(await fileExists('./test/NOT_FOUND')).toBeFalse();
});

test('file read', async () => {
  expect(await readFileContent('./test/file.spec.ts')).toBeDefined();
  expect((await readFileContent('./test/file.spec.ts'))?.length).toBeGreaterThan(0);
});
