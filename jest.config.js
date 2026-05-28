/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
  roots: [
    //'src',
    'lib',
    'test',
  ],
  preset: 'ts-jest',
  testEnvironment: 'node',
  collectCoverage: true,
  collectCoverageFrom: ['index.ts', 'lib/**'],
  setupFilesAfterEnv: ['jest-extended/all'],
  transformIgnorePatterns: ['node_modules/(?!(string-width|strip-ansi|ansi-regex|test-json-import)/)'],
  transform: {
    '^.+\\.(ts|tsx)$': ['ts-jest', { tsconfig: 'tsconfig.test.json' }],
  },
  coverageDirectory: 'coverage',
  coverageReporters: ['lcov', 'text'],
  reporters: ['default', 'jest-junit'],
};
