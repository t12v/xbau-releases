import * as crypto from 'crypto';
import { StandardOverview } from './types';

const md5 = (contents: string) => crypto.createHash('md5').update(contents).digest('hex');

// Build a sorted, stable list of all downloadable identifiers in the overview.
// Timestamps and other volatile metadata are excluded so that metadata-only API
// changes don't produce a false-positive update detection.
function buildManifest(overview: StandardOverview): string[] {
  const items: string[] = [overview.kennung];

  for (const version of overview.versionen) {
    items.push(version.kennung);

    for (const doc of version.dokumente ?? []) {
      for (const dl of doc.downloads ?? []) {
        items.push(dl.kennung);
      }
    }

    for (const cl of version.codeLists ?? []) {
      // Versioned entries use kennung@version; unversioned (expansion errors/IGNORED_URLS)
      // fall back to kennung@timestamp as a best-effort change signal.
      if (cl.version) {
        items.push(`${cl.kennung}@${cl.version}`);
      } else {
        const ts =
          cl.updated instanceof Date && !isNaN(cl.updated.getTime())
            ? cl.updated.toISOString()
            : '';
        items.push(`${cl.kennung}@${ts}`);
      }
    }
  }

  return items.sort();
}

export function getChecksum(overview: StandardOverview): string {
  return md5(buildManifest(overview).join('\n'));
}
