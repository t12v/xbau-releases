/// <reference types="jest-extended" />
import axios from 'axios';
import { searchStandard, getDetails, clearMetadataCache } from '../lib/search';
import { Standard } from '../lib/types';

jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

const MINUTES = 1;
jest.setTimeout(1000 * MINUTES * 60);

beforeEach(() => {
  clearMetadataCache();
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

test('getDetails expands unversioned CODELISTE references into individual versioned kennungen', async () => {
  // Regression: publishing rs_2026-06-30 must end up in codeLists so the checksum
  // changes and the new file is downloaded. Before the fix, only the base kennung
  // was stored and new alleVersionsKennungen entries were never detected.
  mockedAxios.get.mockImplementation((url: string) => {
    if (url === 'urn:test:rs/metadaten') {
      return Promise.resolve({
        data: {
          kennung: 'urn:test:rs',
          alleVersionsKennungen: ['urn:test:rs_2026-04-30', 'urn:test:rs_2026-06-30'],
          referenzen: [],
          dokumente: [],
          zeitpunktLetzteBearbeitung: '2024-01-01T00:00:00+00:00',
        },
      });
    }
    if (url === 'urn:test:v1/metadaten') {
      return Promise.resolve({
        data: {
          kennung: 'urn:test:v1',
          version: '2.6',
          zeitpunktLetzteBearbeitung: '2024-01-01T00:00:00+00:00',
          alleVersionsKennungen: [],
          referenzen: [
            {
              typ: 'CODELISTE',
              kennung: 'urn:test:rs',
              version: '',
              zeitpunktLetzteBearbeitung: '2024-01-01T00:00:00+0000',
            },
          ],
          dokumente: [],
        },
      });
    }
    // standard overview
    return Promise.resolve({
      data: {
        kennung: Standard.XBAU,
        zeitpunktLetzteBearbeitung: '2024-01-01T00:00:00+00:00',
        alleVersionsKennungen: ['urn:test:v1'],
        referenzen: [],
        dokumente: [],
      },
    });
  });

  const details = await getDetails(Standard.XBAU);
  const codeLists = details.versionen[0]?.codeLists ?? [];
  const kennungen = codeLists.map((cl) => cl.kennung);

  expect(kennungen).toContain('urn:test:rs_2026-04-30');
  expect(kennungen).toContain('urn:test:rs_2026-06-30');
  expect(kennungen).not.toContain('urn:test:rs'); // base kennung must not survive expansion
});
