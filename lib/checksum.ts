import * as crypto from 'crypto';

import { Standard } from './types.js';
import { getDetails } from './search.js';

const md5 = (contents: string) => crypto.createHash('md5').update(contents).digest('hex');

export async function getChecksum(standard: Standard): Promise<string> {
  const details = await getDetails(standard);
  const checksum = md5(JSON.stringify(details, null, 2));
  return checksum;
}
