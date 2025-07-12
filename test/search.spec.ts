/// <reference types="jest-extended" />
import { searchStandard, getDetails } from '../lib/search';
import { Standard } from '../lib/types';

const SECONDS = 10;
jest.setTimeout(1000 * SECONDS);

test('search xbau', async () => {
  expect(await getDetails(Standard.XBAU)).toBeDefined();
});

test('load xbau', async () => {
  expect(await searchStandard('xbau')).toBeDefined();
});
