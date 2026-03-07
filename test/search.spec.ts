/// <reference types="jest-extended" />
import axios from 'axios';
import { searchStandard, getDetails } from '../lib/search';
import { Standard } from '../lib/types';

jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

const MINUTES = 1;
jest.setTimeout(1000 * MINUTES * 60);

beforeEach(() => {
  mockedAxios.create.mockReturnValue(mockedAxios);
  mockedAxios.get.mockResolvedValue({ data: { kennung: 'urn:test', alleVersionsKennungen: [] } });
  mockedAxios.post.mockResolvedValue({ data: { hits: [] } });
});

test('search xbau', async () => {
  const details = await getDetails(Standard.XBAU);
  expect(details).toBeDefined();
  expect(details.kennung).toBe('urn:test');
});

test('load xbau', async () => {
  const result = await searchStandard('xbau');
  expect(result).toBeDefined();
  expect(mockedAxios.post).toHaveBeenCalled();
});
