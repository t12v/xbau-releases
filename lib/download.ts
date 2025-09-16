import axios from 'axios';
import axiosRetry from 'axios-retry';
import { rmSync } from 'fs';
import { Standard, UpdateDetails } from './types';
import { artifactsFolder, getEnumKeyByValue } from './utils';
import { fileExists, unzipFile, writeToFile } from './file';
import { dirname, resolve } from 'path';

const BASE_URL = 'https://www.xrepository.de/api/xrepository/';
const apiClient = axios.create({ baseURL: BASE_URL });
const timeout = 120000;

const client = axios.create();
axiosRetry(client, {
  retries: 3, // number of retries
  retryDelay: (retryCount) => {
    console.log(`Retry attempt #${retryCount}`);
    return retryCount * 1000; // exponential backoff
  },
  retryCondition: (error) => {
    // retry on ECONNRESET and network errors
    if (error.code === 'ECONNRESET') return true;
    return axiosRetry.isNetworkOrIdempotentRequestError(error);
  },
});

const IGNORED_ULRS = ['urn:xoev-de:xbau-kernmodul:codeliste:xbau-fehlerkennzahlen'];

function safeParse<T>(json: string, fallback: T): T {
  try {
    return JSON.parse(json) as T;
  } catch {
    return fallback;
  }
}
/* eslint-disable  @typescript-eslint/no-explicit-any */
async function download(file: string, resource: string): Promise<void> {
  const zipFile = file.endsWith('zip');
  //const pdfFile = file.endsWith('pdf');
  const filename = resolve(file);
  if (fileExists(filename)) {
    console.debug(`${filename} already existing. Skipping.`);
    return new Promise((resolve) => {
      resolve();
    });
  }
  const headers: any = {
    'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
    accept: '*/*',
  };
  return client
    .get(resource, {
      headers,
      timeout,
      responseType: 'arraybuffer',
    })
    .then(async (response) => {
      await writeToFile(filename, response.data);
      if (zipFile) {
        const outputDir = dirname(filename);
        await unzipFile(filename, outputDir);
        rmSync(filename);
      }
    })
    .catch((data) => {
      const response = data.response;
      const json = safeParse(response?.data, { fehler: '' });
      if (data.status == 404 && (json?.fehler === 'NUR PLATZHALTER GEFUNDEN' || json?.fehler === 'NICHT SICHTBAR')) {
        console.info(`Skipping ${resource}.`);
        console.debug(`Response for skipped item: ${JSON.stringify(json)}`);
      } else {
        console.error(`Could not Download the file ${resource})`);
        console.debug(`Response for error: ${data}`);
      }
    });
}

function getFolderForType(type: string): string {
  switch (type) {
    case 'XSD':
      return 'xsd';
    case 'originalFachmodellXMI':
      return 'xmi';
    case 'WSDL':
      return 'wsdl';
    default:
      return 'docs';
  }
}

export async function downloadArtifacts(standard: Standard, updates: UpdateDetails): Promise<any> {
  const details = updates.details;
  const rootFolder = `${artifactsFolder}/${getEnumKeyByValue(Standard, standard)}`;
  const downloads = <Array<Promise<void>>>details.versionen.map(async (standard) => {
    const folderName = `${rootFolder}/${standard.version}`;
    const docs = standard?.dokumente ?? [];
    for (const doc of docs) {
      const folder = `${folderName}/${getFolderForType(doc.type)}`;
      if (doc.downloads) {
        for (const item of doc.downloads) {
          await download(`${folder}/${item.kennung}`, item.url);
        }
      }
    }
    const codeLists = new Array<string>();
    const list = standard?.codeLists ?? [];
    for (const codelist of list) {
      if (!IGNORED_ULRS.includes(codelist.kennung)) {
        // without version download all versions
        if (!codelist.version) {
          const detailsResponse = await apiClient.get(`${codelist.kennung}/metadaten`, {
            headers: {
              accept: 'application/json',
              'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
            },
            timeout,
          });
          if (detailsResponse.data) {
            const versions = <Array<string>>(<any>detailsResponse.data).alleVersionsKennungen;
            for (const version of versions) {
              await download(
                `${artifactsFolder}/codelists/${version}.xml`,
                `https://www.xrepository.de/api/xrepository/${version}:technischerBestandteilGenericode`
              );
              codeLists.push(`${version}.xml`);
            }
          }
        } else {
          await download(
            `${artifactsFolder}/codelists/${codelist.kennung}.xml`,
            `https://www.xrepository.de/api/xrepository/${codelist.kennung}:technischerBestandteilGenericode`
          );
          codeLists.push(`${codelist.kennung}.xml`);
        }
      }
    }
    // write code lists as json for each standard
    await writeToFile(`${folderName}/codelists.json`, JSON.stringify(codeLists, null, 4));
  });
  return Promise.all(downloads);
}
