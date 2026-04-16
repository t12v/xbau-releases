# xbau-releases — Claude Code Guide

## Project Overview

This repo downloads, normalises and publishes XBau standard artifacts (codelists, XSDs, docs) from the German xrepository.de API. It produces:
- A **Node.js/TypeScript CLI** (`dist/cli.js`) for checking updates and downloading artifacts
- A **Maven package** (`packages/maven/`) and **npm package** (`packages/npm/`) bundling the artifacts

## Directory Layout

```
artifacts/
  codelists/                   # Shared, individually-downloaded codelist XMLs (colon-named URNs)
  xbau/                        # XBau standard versions (2.0 … 2.6)
    {version}/
      codelists.json           # List of codelist filenames for this version
      codelists/               # Version-specific codelist XMLs (hyphen-named, from ZIP extraction)
      xsd/  docs/  specs/  webservices/  subject_models/
  xbau_kern/                   # XBau-Kernmodul versions (1.0 … 1.3.0)
    {version}/
      codelists.json
      codelists/
      …
lib/
  download.ts    # Core download + artifact collection logic
  search.ts      # xrepository.de API client
  update.ts      # Checksum-based update detection
  file.ts        # File I/O helpers (writeToFile, unzipFile, listFiles)
  checksum.ts    # MD5 checksum generation
  utils.ts       # Shared utilities
  types.ts       # TypeScript types
.bin/
  harmonize-codelist-names.sh  # Renames codelist XMLs to their CanonicalVersionUri
```

## Key Workflows

### `npm run check:updates`
```
check:xbau-updates      → node dist/cli.js update xbau
                          node dist/cli.js update xbau-kernmodul
harmonize-codelist-names.sh
```

1. **update** calls `checkForUpdates` (MD5 checksum of API metadata). If the checksum changed, calls `downloadArtifacts`.
2. **downloadArtifacts** (per version):
   - Docs loop: downloads non-ZIP technical documents into their type folder; skips ZIP bundles in the `codelists/` folder (see below).
   - Codelists loop: downloads each codelist individually to `artifacts/codelists/{kennung}.xml` and builds `codelists.json`.
   - Writes `{version}/codelists.json` with the list of downloaded codelist filenames.
3. **harmonize** renames every `*.xml` in every directory named `codelists/` to its `CanonicalVersionUri` (from inside the XML), appending `.xml`. Skips non-XML files and files where xq returns empty.

### Schedule (CI)
`.github/workflows/schedule.yml` runs daily, calls `check:updates`, then creates a PR via `peter-evans/create-pull-request` if any files changed.

## Codelist Naming Convention

- **Shared codelists** (`artifacts/codelists/`) are downloaded directly and already colon-named, e.g. `urn:de:xoev:codeliste:erreichbarkeit_3.xml`.
- **Version-specific codelists** (`artifacts/xbau/2.2/codelists/`) were historically extracted from a genericode ZIP bundle and committed with hyphen-named URNs, e.g. `urn-de-xoev-codeliste-erreichbarkeit_3.xml`. The harmonize script renames these to colon format on each run.
- `codelists.json` for each version lists only the colon-named files from `artifacts/codelists/`.

## Known Issues & Fixes Applied

### 1. Harmonize empty-check bug (fixed in `19f027b`, restored in working tree)

**Symptom**: All codelist XMLs in version-specific `codelists/` directories appeared deleted after every schedule run (PR #76 showed 140 deletions, 0 additions).

**Root cause**: `.bin/harmonize-codelist-names.sh` appended `.xml` to the xq result *before* checking for empty:
```bash
# BUG — empty check always false because newname is at least ".xml"
newname="$(xq -q 'Identification > CanonicalVersionUri' "$oldname").xml"
[ -z "$newname" ] && { …skip… }
```
When `xq` returned empty (e.g. on a ZIP or unrecognised XML), every file was renamed to `.xml`, each overwriting the previous. All but the last file were effectively deleted.

**Fix**:
```bash
[[ "$oldname" != *.xml ]] && { echo "Skipping non-XML file"; continue; }
newname="$(xq -q 'Identification > CanonicalVersionUri' "$oldname")"
[ -z "$newname" ] && { echo "No CanonicalVersionUri, skipping."; continue; }
newname="$newname.xml"
```

### 2. Genericode ZIP extraction polluting version-specific `codelists/` (fixed in `lib/download.ts`)

**Symptom**: Running `check:updates` caused hyphen-named codelist XMLs (e.g. `urn-de-xoev-codeliste-erreichbarkeit_3.xml`) to appear deleted after harmonize renamed them to colon format.

**Root cause**: `downloadArtifacts` extracted the xrepository.de genericode ZIP bundle into `artifacts/xbau/{version}/codelists/`, creating hyphen-named duplicates of files already individually downloaded to `artifacts/codelists/`. Harmonize renamed them on every run (making them look deleted in git), and since the ZIP was deleted after extraction, it was re-downloaded on every detected update.

**Fix** (`lib/download.ts`): Skip ZIP downloads that would land in a `codelists/` subfolder:
```typescript
if (folder === `${folderName}/codelists` && item.kennung.endsWith('zip')) {
  console.debug(`Skipping genericode ZIP bundle: ${item.kennung}`);
  continue;
}
```
All codelists are already available via the individual API download loop; the ZIP bundle is redundant.

### 3. Committed xbau_kern ZIP files (pending cleanup)

**Symptom**: `artifacts/xbau_kern/*/codelists/genericode.zip` files are still committed to git (they were not removed in `19f027b` which only cleaned up xbau ZIPs). Because `fileExists` returns true, these ZIPs are never re-extracted, leaving stale `.xml/` and `genericode/` subdirectory artifacts.

**Fix needed**: `git rm` the committed ZIPs across all xbau_kern versions and the `.xml/` directory artifacts:
```bash
git rm "artifacts/xbau_kern/*/codelists/*.zip"
git rm -r "artifacts/xbau_kern/*/codelists/.xml"
```

### 4. Hyphen-named files in version-specific `codelists/` (pending rename)

The files committed under `artifacts/xbau/2.2/codelists/` and `artifacts/xbau/2.6/codelists/` still use hyphen names (from before harmonize was working correctly). Running `check:updates` will rename them to colon format. Stage and commit those renames to stabilise the repo. After that, subsequent runs will be no-ops.

### 5. ZIP files downloaded with wrong MIME type (fixed)

**Symptom**: ZIP artifacts were served/stored with the wrong Content-Type (e.g. `application/json`) instead of `application/zip`.

**Root cause**: `defaultDownloadHeaders` in `lib/download.ts` sent `accept: 'application/json'` for all downloads, including binary ZIP files. The xrepository.de API honours content negotiation and returned the wrong `Content-Type`. Additionally, `writeToFile` in `lib/file.ts` was typed as `(file: string, content: string)` but received `ArrayBuffer` for binary downloads — the `as string` cast masked the mismatch.

**Fix** (`lib/download.ts`): Changed `accept` to `'*/*'` so the server sends the native content type:

```typescript
const defaultDownloadHeaders = {
  'accept-language': 'de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7',
  accept: '*/*',
};
```

**Fix** (`lib/file.ts`): Updated `writeToFile` signature to accept binary content:

```typescript
export async function writeToFile(file: string, content: string | ArrayBuffer): Promise<void> {
  await writeFile(file, content instanceof ArrayBuffer ? new Uint8Array(content) : content);
}
```

## Important Notes for Claude

- **Never delete ZIP files manually** — the `download()` function deletes them automatically after extraction (`rmSync`). If `unzipFile` throws, the ZIP is intentionally left on disk so the next run can retry.
- **`codelists.json` is always overwritten** by `downloadArtifacts` (when an update is detected). It only contains codelists from the individual API download loop (`artifacts/codelists/`), not ZIP-extracted files.
- **`IGNORED_URLS`** in `download.ts` excludes `urn:xoev-de:xbau-kernmodul:codeliste:xbau-fehlerkennzahlen` because the xrepository.de API returns a placeholder error for it. It exists only in the ZIP bundle (which is now skipped), so it is intentionally absent from `codelists.json`.
- **Harmonize uses `xq`** (installed via `curl -sSL https://bit.ly/install-xq`) with CSS selector syntax `'Identification > CanonicalVersionUri'` on OASIS GeneriCode XML files.
- The `pLimit(5)` concurrency limiter in `downloadArtifacts` prevents hammering the xrepository.de API with hundreds of simultaneous requests.
