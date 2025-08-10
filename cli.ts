#!/usr/bin/env node

import yargs from 'yargs/yargs';
import { hideBin } from 'yargs/helpers';
import {
  searchStandard,
  getDetailsForStandard,
  Standard,
  isUpdateAvailableForStandard,
  downloadArtifacts,
} from './index.js';

yargs(hideBin(process.argv))
  .env()
  .command(
    'search [standard]',
    'Search for a standard',
    function (yargs) {
      return yargs.option('s', {
        alias: 'standard',
        describe: 'the standard to search for',
        type: 'string',
        choices: ['xbau', 'xbau-kernmodul'],
        default: 'xbau',
      });
    },
    async (argv) => {
      const standard = await searchStandard(argv.standard as string);
      console.log(JSON.stringify(standard, null, 2));
    }
  )
  .command(
    'details [standard]',
    'details for a standard',
    function (yargs) {
      return yargs.option('s', {
        alias: 'standard',
        describe: 'the standard to search for',
        type: 'string',
        choices: ['xbau', 'xbau-kernmodul'],
        default: 'xbau',
      });
    },
    async (argv) => {
      const standard = argv.standard as string;
      if (standard !== 'xbau' && standard !== 'xbau-kernmodul') {
        console.error('Invalid standard. Please choose either "xbau" or "xbau-kernmodul".');
      }
      if (standard === 'xbau-kernmodul') {
        const details = await getDetailsForStandard(Standard.XBAU_KERN);
        console.log(JSON.stringify(details, null, 2));
      } else {
        const details = await getDetailsForStandard(Standard.XBAU);
        console.log(JSON.stringify(details, null, 2));
      }
    }
  )
  .command(
    'update [standard]',
    'update for a standard',
    function (yargs) {
      return yargs
        .option('s', {
          alias: 'standard',
          describe: 'the standard to check for updates',
          type: 'string',
          choices: ['xbau', 'xbau-kernmodul'],
          default: 'xbau',
        })
        .option('w', {
          alias: 'write',
          describe: 'Update the checksum file if it is outdated',
          type: 'boolean',
          default: true,
        });
    },
    async (argv) => {
      const standard = argv.standard as string;
      if (standard !== 'xbau' && standard !== 'xbau-kernmodul') {
        console.error('Invalid standard. Please choose either "xbau" or "xbau-kernmodul".');
      }
      let usedStandard = Standard.XBAU;
      if (standard === 'xbau-kernmodul') {
        usedStandard = Standard.XBAU_KERN;
      }
      const result = await isUpdateAvailableForStandard(usedStandard, argv.write as boolean);
      if (result.updateDetected) {
        console.log(`Update available for ${usedStandard}.`);
        downloadArtifacts(usedStandard, result);
      } else {
        console.log(`No update available for ${usedStandard}.`);
      }
    }
  )
  .parse();
