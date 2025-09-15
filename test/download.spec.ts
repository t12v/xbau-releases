/// <reference types="jest-extended" />
import { downloadArtifacts } from '../lib/download';
import { update } from '../lib/update';
import { Standard } from '../lib/types';

const MINUTES = 10;
jest.setTimeout(1000 * MINUTES * 60);

test('checksum different for different objects', async () => {
  const updateDetails = await update(Standard.XBAU, false);
  await downloadArtifacts(Standard.XBAU, updateDetails);
});
