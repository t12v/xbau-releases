#!/usr/bin/env bash

rm -rf artifacts/xbau*/checksum.md5
rm -rf artifacts/xbau*/*/codelists.json
# Remove cached ZIPs so they are re-downloaded and re-extracted on the next run
find artifacts -name "*.zip" -delete

npm run check:updates