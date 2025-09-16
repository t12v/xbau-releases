export enum Standard {
  XBAU = 'urn:xoev-de:bmk:standard:xbau',
  XBAU_KERN = 'urn:xoev-de:bmk:standard:xbau-kernmodul',
}
export type Download = {
  kennung: string;
  mimeType: string;
  url: string;
};

export type Dokument = {
  kennung: string;
  name: string;
  updated: Date;
  downloads: Array<Download>;
  beschreibung: string;
  type: string;
};

export type CodeList = {
  kennung: string;
  version: string;
  updated: Date;
};

export type StandardOverview = {
  kennung: string;
  updated: Date;
  versionen: Array<StandardDetails>;
};

export type StandardDetails = {
  updated: Date;
  kennung: string;
  version: string;
  referencedStandards: Array<StandardDetails>;
  referencedCodeLists: Array<CodeList>;
  dokumente: Array<Dokument>;
  codeLists?: Array<CodeList>;
};


export type UpdateDetails = {
  updateDetected: boolean;
  details: StandardOverview,
  updated?: Date;
  checksum: string;
};
