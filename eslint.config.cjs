const { defineConfig } = require('eslint/config');

const globals = require('globals');
const tsParser = require('@typescript-eslint/parser');
const typescriptEslint = require('@typescript-eslint/eslint-plugin');
const js = require('@eslint/js');

const { FlatCompat } = require('@eslint/eslintrc');

const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
});

module.exports = defineConfig([
  // DO NOT PUT OTHER PROPS IN THIS OBJECT
  { ignores: ['**/node_modules/**', 'dist/', 'coverage/', 'eslint.config.cjs'] },
  {
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.commonjs,
      },

      parser: tsParser,
    },

    extends: compat.extends('eslint:recommended', 'plugin:@typescript-eslint/recommended'),

    plugins: {
      '@typescript-eslint': typescriptEslint,
    },

    rules: {
      quotes: [
        2,
        'single',
        {
          avoidEscape: true,
        },
      ],

      'comma-dangle': ['error', 'only-multiline'],
    },
  },
]);
