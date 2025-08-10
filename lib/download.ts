import axios from 'axios';
import { Standard, StandardOverview, StandardDetails, CodeList, Dokument, UpdateDetails } from './types';
import { getEnumKeyByValue } from './utils';
import { fileExists, writeToFile } from './file';
import { version } from 'yargs';

const BASE_URL = 'https://www.xrepository.de/api/xrepository/';
const apiClient = axios.create({ baseURL: BASE_URL });
const timeout = 30000;

const IGNORED_ULRS = [BASE_URL + 'urn:xoev-de:xbau-kernmodul:codeliste:xbau-fehlerkennzahlen'];

/* eslint-disable  @typescript-eslint/no-explicit-any */
async function download(filename: string, resource: string): Promise<void> {
  return axios
    .create()
    .get(resource, {
      headers: {
        'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
      },
      timeout,
      responseType: 'blob',
    })
    .then(async (response) => {
      // Log somewhat to show that the browser actually exposes the custom HTTP header
      const fileNameHeader = 'x-suggested-filename';
      const suggestedFileName = response.headers[fileNameHeader];
      const effectiveFileName = suggestedFileName === undefined ? 'allergierOchPreferenser.xls' : suggestedFileName;
      console.log(
        `Received header [${fileNameHeader}]: ${suggestedFileName}, effective fileName: ${effectiveFileName}`
      );
      await writeToFile(filename, response.data);
    })
    .catch((data) => {
      const response = data.response;
      if (response.data && data.status == 404 && JSON.parse(response.data).fehler == 'NUR PLATZHALTER GEFUNDEN') {
        console.info(`Skipping placeholder codelist for  ${resource}`);
      } else {
        console.error('Could not Download the file'); //, data);
      }
    });
}
export async function downloadArtifacts(standard: Standard, updates: UpdateDetails): Promise<void> {
  const details = updates.details;
  const rootFolder = getEnumKeyByValue(Standard, standard);
  return details.versionen.forEach(async (standard) => {
    const folderName = `${rootFolder}/${standard.version}`;
    standard.codeLists?.forEach(async (codelist) => {
      const fileName = `${folderName}/codelists/${codelist.kennung}.xml`;
      if (!(await fileExists(fileName)) && IGNORED_ULRS.includes(`${BASE_URL}/${codelist.kennung}`)) {
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
            versions.forEach((version) => {
              return download(
                `${folderName}/codelists/${codelist.kennung}_${version}.xml`,
                `https://www.xrepository.de/api/xrepository/${codelist.kennung}:technischerBestandteilGenericode`
              );
            });
          }
        }
        return download(
          fileName,
          `https://www.xrepository.de/api/xrepository/${codelist.kennung}:technischerBestandteilGenericode`
        );
      }
    });
  });
}
