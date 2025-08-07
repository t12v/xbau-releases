/// <reference types="jest-extended" />
import { getChecksum } from '../lib/checksum';

const SECONDS = 10;
jest.setTimeout(1000 * SECONDS);

test('checksum different for different objects', async () => {
  const checksumXbau = await getChecksum({ name: 'XBAU' });
  const checksumXbauKernmodul = await getChecksum({ name: 'XBAU2' });
  expect(checksumXbau !== checksumXbauKernmodul).toBeTrue();
});

test('checksum same for same objects', async () => {
  const checksumXbau = await getChecksum({ name: 'XBAU' });
  const checksumXbauKernmodul = await getChecksum({ name: 'XBAU' });
  expect(checksumXbau === checksumXbauKernmodul).toBeTrue();
});
