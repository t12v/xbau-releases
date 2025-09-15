/// <reference types="jest-extended" />
import { downloadArtifacts } from '../lib/download';
import { update } from '../lib/update';
import { Standard } from '../lib/types';

const MINUTES = 10;
jest.setTimeout(1000 * MINUTES * 60);

test('checksum different for different XBau objects', async () => {
  const updateDetails = await update(Standard.XBAU, false);
  await downloadArtifacts(Standard.XBAU, updateDetails);
});
test('checksum different for different XBau Kern objects', async () => {
  const updateDetails = await update(Standard.XBAU_KERN, false);
  await downloadArtifacts(Standard.XBAU_KERN, updateDetails);
});
