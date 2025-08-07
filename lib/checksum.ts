import * as crypto from 'crypto';
const md5 = (contents: string) => crypto.createHash('md5').update(contents).digest('hex');

export async function getChecksum(json: object): Promise<string> {
  const checksum = md5(JSON.stringify(json, null, 2));
  return checksum;
}
