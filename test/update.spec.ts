/// <reference types="jest-extended" />
import { Standard } from '../lib/types';
import { update } from '../lib/update';

const SECONDS = 10;
jest.setTimeout(1000 * SECONDS);

test('check for updates', async () => {
  expect(await update(Standard.XBAU, false)).toBeDefined();
});
