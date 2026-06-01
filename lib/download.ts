import axios from 'axios';
import axiosRetry from 'axios-retry';
import pLimit from 'p-limit';

import { dirname, resolve } from 'path';
import xmlFormatter from 'xml-formatter';
import { Standard, UpdateDetails } from './types';
import { artifactsFolder, getEnumKeyByValue } from './utils';
import { fileExists, unzipFile, writeToFile } from './file';

const BASE_URL = 'https://www.xrepository.de/api/xrepository/';
const apiClient = axios.create({ baseURL: BASE_URL });
const timeout = 120000;

const client = axios.create();
axiosRetry(client, {
  retries: 3, // number of retries
  retryDelay: (retryCount) => retryCount * 1000, // exponential backoff
  retryCondition: (error) =>
    error.code === 'ECONNRESET' || axiosRetry.isNetworkOrIdempotentRequestError(error),
});

const defaultDownloadHeaders = {
  'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
  accept: '*/*',
};

const IGNORED_URLS = ['urn:xoev-de:xbau-kernmodul:codeliste:xbau-fehlerkennzahlen'];

function safeParse<T>(json: string, fallback: T): T {
  try {
    return JSON.parse(json) as T;
  } catch {
    return fallback;
  }
}

async function download(file: string, resource: string): Promise<void> {
  const zipFile = file.endsWith('zip');
  const filename = resolve(file);
  if (fileExists(filename)) {
    console.debug(`${filename} already existing. Skipping.`);
    return;
  }

  console.debug(`[download] Fetching: ${resource} → ${filename}`);
  try {
    const response = await client.get<ArrayBuffer>(resource, {
      headers: defaultDownloadHeaders,
      timeout,
      responseType: 'arraybuffer',
    });

    console.debug(`[download] Writing ${response.data.byteLength} bytes to ${filename}`);
    let content: string | ArrayBuffer = response.data;
    if (filename.endsWith('.xml') || filename.endsWith('.sch')) {
      // pretty-print XML
      content = xmlFormatter(new TextDecoder().decode(content), {
        indentation: '  ',
        collapseContent: true,
        lineSeparator: '\n',
      });
    }
    await writeToFile(filename, content);
    console.debug(`[download] Successfully wrote: ${filename}`);

    if (zipFile) {
      const outputDir = dirname(filename);
      await unzipFile(filename, outputDir);
      // Keep the ZIP on disk — it serves as the existence marker for the next
      // fileExists() check above. Deleting it would cause a re-download on every
      // run. ZIPs in artifacts/xbau* are gitignored so they won't be tracked.
    }
  } catch (err: unknown) {
    if (!axios.isAxiosError(err)) {
      console.error(`Could not download the file ${resource}`, err instanceof Error ? err.message : err);
      console.debug(`Response for error: ${err}`);
      return;
    }
    const json = safeParse(String(err.response?.data ?? ''), { fehler: '' });
    if (
      err.response?.status === 404 &&
      (json?.fehler === 'NUR PLATZHALTER GEFUNDEN' || json?.fehler === 'NICHT SICHTBAR' || json?.fehler === '')
    ) {
      console.info(`Skipping ${resource}.`);
      console.debug(`Response for skipped item: ${JSON.stringify(json)}`);
    } else {
      console.error(`Could not download the file ${resource}: HTTP ${err.response?.status} - ${err.message}`);
      if (err.response?.data) {
        console.debug(`Response body: ${JSON.stringify(json)}`);
      }
    }
  }
}

// simple concurrency limiter to avoid hundreds of simultaneous requests
const DOWNLOAD_LIMIT = 5;
const limit = pLimit(DOWNLOAD_LIMIT);

function getFolderForType(type: string): string {
  switch (type) {
    case 'XSD':
      return 'xsd';
    case 'originalFachmodellXMI':
    case 'originalFachmodellProprietaer':
      return 'subject_models';
    case 'WEITERER_TECHNISCHER_BESTANDTEIL':
      return 'specs';
    case 'WSDL':
      return 'webservices';
    default:
      return 'docs';
  }
}

export async function downloadArtifacts(standard: Standard, updates: UpdateDetails): Promise<void> {
  const details = updates.details;
  const rootFolder = `${artifactsFolder}/${getEnumKeyByValue(Standard, standard)}`;
  const downloads = details.versionen.map((standard) =>
    limit(async () => {
      try {
        const codeLists: string[] = [];
        const list = standard?.codeLists ?? [];
        const folderName = `${rootFolder}/${standard.version}`;
        const docs = standard?.dokumente ?? [];
        for (const doc of docs) {
          let folder = `${folderName}/${getFolderForType(doc.type)}`;
          if (doc.name.match(/codelisten/i)) {
            folder = `${folderName}/codelists`;
          }
          if (doc.downloads) {
            for (const item of doc.downloads) {
              // Skip ZIP bundles in the codelists folder — individual codelists are already
              // downloaded to artifacts/codelists/ via the codeLists loop below.
              // Extracting the ZIP here would create hyphen-named duplicates that conflict
              // with the harmonize step.
              if (folder === `${folderName}/codelists` && item.kennung.endsWith('zip')) {
                console.debug(`Skipping genericode ZIP bundle: ${item.kennung}`);
                continue;
              }
              await download(`${folder}/${item.kennung}`, item.url);
            }
          }
        }
        for (const codelist of list) {
          if (!IGNORED_URLS.includes(codelist.kennung)) {
            if (!codelist.version) {
              const detailsResponse = await apiClient.get(`${codelist.kennung}/metadaten`, {
                headers: defaultDownloadHeaders,
                timeout,
              });
              if (detailsResponse.data) {
                const versions: string[] = Array.isArray(detailsResponse.data.alleVersionsKennungen)
                  ? detailsResponse.data.alleVersionsKennungen
                  : [];
                console.debug(`[downloadArtifacts] Expanding unversioned ${codelist.kennung} to ${versions.length} versions`);
                for (const version of versions) {
                  console.debug(`[downloadArtifacts] Downloading: ${version}`);
                  await download(
                    `${artifactsFolder}/codelists/${version}.xml`,
                    `${BASE_URL}${version}:technischerBestandteilGenericode`
                  );
                  codeLists.push(`${version}.xml`);
                }
              }
            } else {
              console.debug(`[downloadArtifacts] Downloading versioned: ${codelist.kennung}`);
              await download(
                `${artifactsFolder}/codelists/${codelist.kennung}.xml`,
                `${BASE_URL}${codelist.kennung}:technischerBestandteilGenericode`
              );
              codeLists.push(`${codelist.kennung}.xml`);
            }
          }
        }
        await writeToFile(`${folderName}/codelists.json`, JSON.stringify(codeLists, null, 4));
      } catch (err) {
        console.error(`Error processing version ${standard.version}:`, err);
      }
    })
  );
  await Promise.all(downloads);
}
