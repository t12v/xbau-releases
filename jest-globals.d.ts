import type { Jest } from '@jest/environment';

// @types/jest v30 removed the `declare var jest` value declaration (only keeps the namespace).
// TypeScript 6 enforces TS2708 ("Cannot use namespace as a value"), so we re-add it here,
// merging with the existing namespace from @types/jest.
declare const jest: Jest;
