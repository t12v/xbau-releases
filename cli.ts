#!/usr/bin/env node

import yargs from 'yargs/yargs';
import { hideBin } from 'yargs/helpers';
import { searchStandard } from './index.js';

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
  .parse();
