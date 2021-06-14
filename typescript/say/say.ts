const digitWords = [
  "",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
  "ten",
  "eleven",
  "twelve",
  "thirteen",
  "fourteen",
  "fifteen",
];

const tensPrefix = [
  "",
  "",
  "twenty",
  "thirty",
  "forty",
  "fifty",
  "sixty",
  "seventy",
  "eighty",
  "ninety",
];

function isCommonTeen(num: number): boolean {
  return num >= digitWords.length && num < 20;
}

function standardTranslation(num: number): string {
  let translation: string = "";

  const numberDigits = num.toString().split('').reverse();
  const digits = parseInt(numberDigits[0]);
  const tens = parseInt(numberDigits[1]);
  // const hundreds = parseInt(numberDigits[2]);


  let hundreds = translateGroup(num, 100, "hundred");
  translation = hundreds.text;
  num = hundreds.num;

  if (num < digitWords.length) {
    return `${translation}${digitWords[num]}`;
  }

  if (isCommonTeen(num)) {
    return `${translation}${digitWords[num]}teen`;
  }

  if (tens > 0 && digits == 0) {
    translation = `${translation}${tensPrefix[tens]}`;
  }

  if (tens > 0 && digits > 0) {
    translation = `${translation}${tensPrefix[tens]}-${digitWords[digits]}`;
  }

  if (tens <= 0 && digits > 0) {
    translation = `${digitWords[digits]}`;
  }

  return translation.trim();
}

interface TranslationGroup {
  num: number;
  text: string;
}

function translateGroup(
  num: number,
  groupBase: number,
  label: string
): TranslationGroup {
  const belongsToGroup = Math.floor(num / groupBase) > 0;
  if (belongsToGroup) {
    const groupValue = Math.floor(num / groupBase);

    return {
      num: num - groupValue * groupBase,
      text: `${standardTranslation(groupValue)} ${label} `,
    };
  }

  return { num: num, text: "" };
}

function translateGroups(num: number): string {
  let translation = translateGroup(num, 1000000000, "billion");
  let text = translation.text;
  num = translation.num;

  translation = translateGroup(num, 1000000, "million");
  text = `${text}${translation.text}`;
  num = translation.num;

  translation = translateGroup(num, 1000, "thousand");
  text = `${text}${translation.text}`;
  num = translation.num;

  return `${text}${standardTranslation(num)}`;
}

export default class Say {
  inEnglish(num: number): string {
    if (num < 0 || num > 999999999999) {
      throw new Error("Number must be between 0 and 999,999,999,999.");
    }

    if (num === 0) {
      return "zero";
    }

    return translateGroups(num).trim();
  }
}
