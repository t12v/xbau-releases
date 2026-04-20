#!/usr/bin/env bash

rm -rf standards codelists
mkdir -p standards
mkdir -p codelists

cp -rp ../../artifacts/codelists/* codelists
cp -rp ../../artifacts/xbau/* standards
cp -rp ../../artifacts/xbau_kern/* standards


find standards -type f \( \
  -iname "*.zip" -o \
  -iname "*.mdxml" -o \
  -iname "*.uml" -o \
  -iname "*.pdf" \
\) -delete
