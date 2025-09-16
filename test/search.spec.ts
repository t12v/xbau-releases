/// <reference types="jest-extended" />
import { searchStandard, getDetails } from '../lib/search';
import { Standard } from '../lib/types';

const MINUTES = 1;
jest.setTimeout(1000 * MINUTES * 60);

test('search xbau', async () => {
  expect(await getDetails(Standard.XBAU)).toBeDefined();
});

test('load xbau', async () => {
  expect(await searchStandard('xbau')).toBeDefined();
});
