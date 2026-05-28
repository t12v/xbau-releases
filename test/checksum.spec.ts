/// <reference types="jest-extended" />
import { getChecksum } from '../lib/checksum';
import { StandardOverview } from '../lib/types';

const SECONDS = 10;
jest.setTimeout(1000 * SECONDS);

function makeOverview(kennung: string): StandardOverview {
  return { kennung, updated: new Date(), versionen: [] };
}

test('checksum different for different objects', () => {
  const checksumXbau = getChecksum(makeOverview('urn:xoev-de:bmk:standard:xbau'));
  const checksumXbauKernmodul = getChecksum(makeOverview('urn:xoev-de:bmk:standard:xbau-kernmodul'));
  expect(checksumXbau !== checksumXbauKernmodul).toBeTrue();
});

test('checksum same for same objects', () => {
  const checksumXbau = getChecksum(makeOverview('urn:xoev-de:bmk:standard:xbau'));
  const checksumXbauKernmodul = getChecksum(makeOverview('urn:xoev-de:bmk:standard:xbau'));
  expect(checksumXbau === checksumXbauKernmodul).toBeTrue();
});

test('checksum ignores timestamp changes', () => {
  const overview1: StandardOverview = {
    kennung: 'urn:xoev-de:bmk:standard:xbau',
    updated: new Date('2024-01-01'),
    versionen: [],
  };
  const overview2: StandardOverview = {
    kennung: 'urn:xoev-de:bmk:standard:xbau',
    updated: new Date('2025-06-01'),
    versionen: [],
  };
  expect(getChecksum(overview1)).toBe(getChecksum(overview2));
});

test('checksum changes when a new versioned codelist kennung is added to codeLists', () => {
  // Regression: publishing rs_2026-06-30 must invalidate the checksum so the
  // new file is downloaded. Before the fix, only the base kennung was in the
  // manifest and new alleVersionsKennungen entries were invisible to the checksum.
  function makeOverviewWithCodelists(codeLists: { kennung: string; version: string }[]): StandardOverview {
    return {
      kennung: 'urn:xoev-de:bmk:standard:xbau',
      updated: new Date(),
      versionen: [
        {
          kennung: 'urn:xoev-de:bmk:standard:xbau_2.6',
          version: '2.6',
          updated: new Date(),
          referencedCodeLists: [],
          referencedStandards: [],
          dokumente: [],
          codeLists: codeLists.map((cl) => ({ ...cl, updated: new Date() })),
        },
      ],
    };
  }

  const before = makeOverviewWithCodelists([
    { kennung: 'urn:de:bund:destatis:schluessel:rs_2026-04-30', version: 'urn:de:bund:destatis:schluessel:rs_2026-04-30' },
  ]);
  const after = makeOverviewWithCodelists([
    { kennung: 'urn:de:bund:destatis:schluessel:rs_2026-04-30', version: 'urn:de:bund:destatis:schluessel:rs_2026-04-30' },
    { kennung: 'urn:de:bund:destatis:schluessel:rs_2026-06-30', version: 'urn:de:bund:destatis:schluessel:rs_2026-06-30' },
  ]);

  expect(getChecksum(before)).not.toBe(getChecksum(after));
});

test('checksum is stable when versioned codelist timestamp changes but kennungen are unchanged', () => {
  function makeOverviewWithCodelistAt(updated: Date): StandardOverview {
    return {
      kennung: 'urn:xoev-de:bmk:standard:xbau',
      updated: new Date(),
      versionen: [
        {
          kennung: 'urn:xoev-de:bmk:standard:xbau_2.6',
          version: '2.6',
          updated: new Date(),
          referencedCodeLists: [],
          referencedStandards: [],
          dokumente: [],
          codeLists: [
            { kennung: 'urn:de:bund:destatis:schluessel:rs_2026-04-30', version: 'urn:de:bund:destatis:schluessel:rs_2026-04-30', updated },
          ],
        },
      ],
    };
  }

  expect(getChecksum(makeOverviewWithCodelistAt(new Date('2024-01-01')))).toBe(
    getChecksum(makeOverviewWithCodelistAt(new Date('2025-06-01')))
  );
});

test('checksum changes when a new version kennung is added', () => {
  const base: StandardOverview = {
    kennung: 'urn:xoev-de:bmk:standard:xbau',
    updated: new Date(),
    versionen: [],
  };
  const withVersion: StandardOverview = {
    kennung: 'urn:xoev-de:bmk:standard:xbau',
    updated: new Date(),
    versionen: [
      {
        kennung: 'urn:xoev-de:bmk:standard:xbau_2.6',
        version: '2.6',
        updated: new Date(),
        referencedCodeLists: [],
        referencedStandards: [],
        dokumente: [],
        codeLists: [],
      },
    ],
  };
  expect(getChecksum(base)).not.toBe(getChecksum(withVersion));
});
