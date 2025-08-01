/// <reference types="jest-extended" />
import { getChecksum } from '../lib/checksum';
import { Standard } from '../lib/types';

const SECONDS = 10;
jest.setTimeout(1000 * SECONDS);

test('checksum different for different standards', async () => {
  const checksumXbau = await getChecksum(Standard.XBAU);
  const checksumXbauKernmodul = await getChecksum(Standard.XBAU_KERN);
  expect(checksumXbau !== checksumXbauKernmodul).toBeTrue();
});

test('checksum same for same standards', async () => {
  const checksumXbau = await getChecksum(Standard.XBAU);
  const checksumXbauKernmodul = await getChecksum(Standard.XBAU);
  expect(checksumXbau === checksumXbauKernmodul).toBeTrue();
});
