import axios from 'axios';
import { Standard, StandardOverview, StandardDetails, CodeList, Dokument } from './types';

const BASE_URL = 'https://www.xrepository.de/api/xrepository/';
const apiClient = axios.create({ baseURL: BASE_URL });

const timeout = 10000;

type References = {
  codelists: Array<CodeList>;
  standards: Array<StandardDetails>;
};

/* eslint-disable  @typescript-eslint/no-explicit-any */
async function extractReferences(docs: Array<any>): Promise<References> {
  const codelists: Array<CodeList> = [];
  const standards: Array<StandardDetails> = [];
  for (const reference of docs) {
    if (reference.typ === 'VERSION_CODELISTE' || reference.typ === 'CODELISTE') {
      codelists.push({
        kennung: reference.kennung,
        version: reference.version,
        updated: new Date(reference.zeitpunktLetzteBearbeitung),
      });
    }
    if (reference.typ === 'VERSION_STANDARD') {
      // Insert colon in timezone offset
      const fixedInput = reference.zeitpunktLetzteBearbeitung.replace(/([+-]\d{2})(\d{2})$/, '$1:$2');
      const updated = new Date(fixedInput);
      const detailsResponse = apiClient.get(`${reference.kennung}/metadaten`, {
        headers: {
          accept: 'application/json',
          'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
        },
        timeout,
      });
      const details = (await detailsResponse).data;
      const refs = await extractReferences(details.referenzen);

      const codeLists = refs.codelists || [];
      for (const standard of refs.standards) {
        if (standard.codeLists) {
          for (const codeList of standard.codeLists) {
            if (!codeLists.some((cl) => cl.kennung === codeList.kennung)) {
              codeLists.push(codeList);
            }
          }
        }
      }
      standards.push({
        kennung: reference.kennung,
        version: reference.version,
        updated,
        referencedCodeLists: refs.codelists,
        referencedStandards: refs.standards,
        dokumente: [],
        codeLists,
      });
    }
  }
  return {
    codelists,
    standards,
  };
}
export async function getDetails(standard: Standard): Promise<StandardOverview> {
  const response = apiClient.get(`${standard}/metadaten`, {
    headers: {
      accept: 'application/json',
      'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
    },
    timeout,
  });
  const overview = (await response).data;
  // Insert colon in overview offset
  const fixedInput = overview.zeitpunktLetzteBearbeitung.replace(/([+-]\d{2})(\d{2})$/, '$1:$2');
  const updated = new Date(fixedInput);
  const result: StandardOverview = {
    kennung: overview.kennung,
    updated,
    versionen: [],
  };
  for (const kennung of overview.alleVersionsKennungen) {
    const detailsResponse = apiClient.get(`${kennung}/metadaten`, {
      headers: {
        accept: 'application/json',
        'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
      },
      timeout,
    });
    const details = (await detailsResponse).data;
    const refs = await extractReferences(details.referenzen);

    const dokumente: Array<Dokument> = [];
    for (const doc of details.dokumente) {
      const dok: Dokument = {
        kennung: doc.kennung,
        name: doc.name,
        beschreibung: doc.beschreibung,
        updated: doc.zeitpunktLetzteBearbeitung,
        downloads: [],
      };
      for (const download of doc.datei) {
        dok.downloads.push({
          kennung: download.kennung,
          mimeType: download.mimeType,
          url: BASE_URL + download.kennung,
        });
      }
      dokumente.push(dok);
    }

    const codeLists = refs.codelists || [];
    for (const standard of refs.standards) {
      if (standard.codeLists) {
        for (const codeList of standard.codeLists) {
          if (!codeLists.some((cl) => cl.kennung === codeList.kennung)) {
            codeLists.push(codeList);
          }
        }
      }
    }

    result.versionen.push({
      kennung: details.kennung,
      version: details.version,
      updated: details.zeitpunktLetzteBearbeitung,
      referencedCodeLists: refs.codelists,
      referencedStandards: refs.standards,
      dokumente,
      codeLists,
    });
  }
  result.versionen.sort(function (a, b) {
    // Turn your strings into dates, and then subtract them
    // to get a value that is either negative, positive, or zero.
    return new Date(b.updated).getTime() - new Date(a.updated).getTime();
  });
  return result;
}

export async function searchStandard(searchString: string): Promise<object> {
  const response = apiClient.post(
    'suche?page=0&size=10&sort=zeitpunktLetzteBearbeitung%20DESC',
    {
      typen: ['STANDARD'],
      match: searchString,
    },
    {
      headers: {
        accept: 'application/json',
        'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
      },
      timeout,
    }
  );
  return (await response).data;
}
