export function getEnumKeyByValue<T extends Record<string, string | number>>(
  enumObj: T,
  value: T[keyof T]
): string | undefined {
  const key = Object.entries(enumObj).find((entry) => entry[1] === value)?.[0];
  return key?.toLowerCase();
}
