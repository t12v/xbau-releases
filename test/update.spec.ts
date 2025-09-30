/// <reference types="jest-extended" />
import { Standard } from '../lib/types';
import { update } from '../lib/update';

const MINUTES = 1;
jest.setTimeout(1000 * MINUTES * 60);

test('check for updates', async () => {
  expect(await update(Standard.XBAU, false)).toBeDefined();
});

test('check for updates', async () => {
  expect(await update(Standard.XBAU_KERN, false)).toBeDefined();
});
