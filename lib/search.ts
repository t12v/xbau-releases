import axios from 'axios';
import { Standard, StandardOverview, StandardDetails, CodeList, Dokument } from './types';

const BASE_URL = 'https://www.xrepository.de/api/xrepository/';
let _apiClient: ReturnType<typeof axios.create> | undefined;
const getApiClient = () => {
  if (!_apiClient) {
    _apiClient = axios.create({ baseURL: BASE_URL });
  }
  return _apiClient;
};

const timeout = 10000;

const defaultHeaders = {
  accept: 'application/json',
  'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
};

interface References {
  codelists: CodeList[];
  standards: StandardDetails[];
}

interface ApiDatei {
  kennung: string;
  mimeType: string;
}

interface ApiDokument {
  dokumentenkategorie: string;
  kennung: string;
  name: string;
  beschreibung: string;
  zeitpunktLetzteBearbeitung: string;
  datei: ApiDatei[];
}

interface ApiReference {
  typ: string;
  kennung: string;
  version: string;
  zeitpunktLetzteBearbeitung: string;
}

interface ApiMetadata {
  kennung: string;
  version: string;
  zeitpunktLetzteBearbeitung: string;
  alleVersionsKennungen: string[];
  referenzen: ApiReference[];
  dokumente: ApiDokument[];
}

// helper cache for metadata lookups to avoid re-fetching the same
const metadataCache: Map<string, ApiMetadata> = new Map();

export function clearMetadataCache(): void {
  metadataCache.clear();
}

async function fetchMetadata(kennung: string): Promise<ApiMetadata> {
  if (metadataCache.has(kennung)) {
    return metadataCache.get(kennung) as ApiMetadata;
  }
  const resp = await getApiClient().get<ApiMetadata>(`${kennung}/metadaten`, {
    headers: defaultHeaders,
    timeout,
  });
  metadataCache.set(kennung, resp.data);
  return resp.data;
}

async function extractReferences(docs: ApiReference[] = []): Promise<References> {
  const codelists: CodeList[] = [];
  const standards: StandardDetails[] = [];

  for (const reference of docs) {
    switch (reference.typ) {
      case 'VERSION_CODELISTE':
      case 'CODELISTE':
        codelists.push({
          kennung: reference.kennung,
          version: reference.version,
          updated: new Date(reference.zeitpunktLetzteBearbeitung),
        });
        break;
      case 'VERSION_STANDARD': {
        const fixedInput = reference.zeitpunktLetzteBearbeitung.replace(/([+-]\d{2})(\d{2})$/, '$1:$2');
        const updated = new Date(fixedInput);
        const details = await fetchMetadata(reference.kennung);
        const refs = await extractReferences(details.referenzen);

        const codeLists = refs.codelists.slice(); // copy
        for (const std of refs.standards) {
          if (std.codeLists) {
            for (const cl of std.codeLists) {
              if (!codeLists.some((existing) => existing.kennung === cl.kennung)) {
                codeLists.push(cl);
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
        break;
      }
      default:
        // unknown type can be ignored
        break;
    }
  }
  return { codelists, standards };
}
export async function getDetails(standard: Standard): Promise<StandardOverview> {
  const overview = await fetchMetadata(standard);
  // Insert colon in overview offset
  const fixedInput = (overview.zeitpunktLetzteBearbeitung ?? '').replace(/([+-]\d{2})(\d{2})$/, '$1:$2');
  const updated = new Date(fixedInput);
  const result: StandardOverview = {
    kennung: overview.kennung,
    updated,
    versionen: [],
  };
  for (const kennung of overview.alleVersionsKennungen) {
    const details = await fetchMetadata(kennung);
    const refs = await extractReferences(details.referenzen);

    const dokumente: Array<Dokument> = [];
    for (const doc of details.dokumente) {
      const dok: Dokument = {
        type: doc.dokumentenkategorie,
        kennung: doc.kennung,
        name: doc.name,
        beschreibung: doc.beschreibung,
        updated: new Date(doc.zeitpunktLetzteBearbeitung),
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

    console.debug(`[getDetails] Version ${details.version}: collected ${codeLists.length} codelists before expansion`);
    codeLists.forEach((cl) => console.debug(`  - ${cl.kennung} (version: ${cl.version})`));

    // Expand unversioned codelists (CODELISTE references) to their individual versioned
    // kennungen by fetching alleVersionsKennungen. This makes the checksum sensitive to
    // newly published versions rather than relying on volatile reference timestamps.
    const expandedCodeLists: CodeList[] = [];
    for (const cl of codeLists) {
      if (cl.version) {
        expandedCodeLists.push(cl);
        console.debug(`[getDetails] Keeping versioned codelist: ${cl.kennung}@${cl.version}`);
      } else {
        try {
          console.debug(`[getDetails] Expanding unversioned codelist: ${cl.kennung}`);
          const meta = await fetchMetadata(cl.kennung);
          const versions = meta.alleVersionsKennungen ?? [];
          console.debug(`[getDetails]   Found ${versions.length} versions for ${cl.kennung}: ${versions.join(', ')}`);
          for (const vKennung of versions) {
            expandedCodeLists.push({ kennung: vKennung, version: vKennung, updated: cl.updated });
          }
        } catch (err) {
          expandedCodeLists.push(cl); // keep as-is; downloadArtifacts handles errors/IGNORED_URLS
          console.debug(`Could not expand unversioned codelist ${cl.kennung}:`, err instanceof Error ? err.message : err);
        }
      }
    }
    console.debug(`[getDetails] Version ${details.version}: expanded to ${expandedCodeLists.length} codelists`);

    result.versionen.push({
      kennung: details.kennung,
      version: details.version,
      updated: new Date(details.zeitpunktLetzteBearbeitung.replace(/([+-]\d{2})(\d{2})$/, '$1:$2')),
      referencedCodeLists: refs.codelists,
      referencedStandards: refs.standards,
      dokumente,
      codeLists: expandedCodeLists,
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
  const response = getApiClient().post(
    'suche?page=0&size=10&sort=zeitpunktLetzteBearbeitung%20DESC',
    {
      typen: ['STANDARD'],
      match: searchString,
    },
    {
      headers: defaultHeaders,
      timeout,
    }
  );
  return (await response).data;
}
