import * as crypto from 'crypto';
const md5 = (contents: string) => crypto.createHash('md5').update(contents).digest('hex');

export function getChecksum(json: object): string {
  return md5(JSON.stringify(json, null, 2));
}
