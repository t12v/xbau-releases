---
name: project-checksum-false-positives
description: Root cause and fix for update check triggering with no artifact changes — checksum included volatile API timestamps
metadata: 
  node_type: memory
  type: project
  originSessionId: 1d2f7506-cafb-4494-88aa-e3ba3f396126
---

The `checkForUpdates` flow was producing false-positive "update detected" results: checksum files changed on every CI run but `downloadArtifacts` downloaded nothing (all files already existed via `fileExists` guard).

**Why:** `getChecksum` in `lib/checksum.ts` computed MD5 of the full `StandardOverview` JSON, which includes `Date` objects from the xrepository.de API's `zeitpunktLetzteBearbeitung` field. The API updates these timestamps for metadata-only changes (descriptions, references) even when no downloadable artifact files change. A second bug: `readFileContent` returns raw file content including any trailing newline, but the computed checksum has none — `"abc\n" !== "abc"` — causing the first read of a freshly-committed checksum file to always mismatch.

**Fix applied (2026-05-28):**
- `lib/checksum.ts`: `getChecksum` now takes `StandardOverview` and builds a **stable manifest** — sorted list of `overview.kennung`, version kennungen, document download kennungen, and codelist kennungen (with `kennung@version` for versioned ones). Timestamps excluded. Checksum only changes when actual downloadable content is new.
- `lib/update.ts:21`: Added `.trim()` to checksum comparison to tolerate trailing whitespace in committed files.

**How to apply:** If the CI schedule creates PRs that only change `checksum.md5` files with no artifact changes, suspect this area. The fix is now in place — if it recurs, check whether a new volatile field was added to `StandardOverview` that's being included in checksum computation.

**One-time side effect:** Existing committed checksums were computed with the old method. First run after deploy produces a one-time false positive (update detected, nothing downloaded, checksums rewritten to new format). Subsequent runs stable.
