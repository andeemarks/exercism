import { stringify } from "querystring";

export default class Luhn {
  private static hasInvalidCharacters(number: string): boolean {
    const numberWithoutSpaces = number.replace(/\ /g, "");
    const numberWithOnlyDigits = number.replace(/\D/g, "");

    return numberWithoutSpaces != numberWithOnlyDigits;
  }

  private static doubleAndNormaliseIfNeeded(digit: number): number {
    const doubledDigit = digit * 2;
    if (doubledDigit > 9) {
      return doubledDigit - 9;
    } else {
      return doubledDigit;
    }
  }

  public static valid(number: string): boolean {
    if (this.hasInvalidCharacters(number)) {
      return false;
    }

    const numberWithOnlyDigits = Array.from(
      number.replace(/\D/g, "")
    ).reverse();

    const numberWithDoubledDigits = numberWithOnlyDigits.map(
      (digit: string, i: number) => {
        const isEvenPlacedDigit = i % 2 == 0;
        if (isEvenPlacedDigit) {
          return Number.parseInt(digit);
        } else {
          return this.doubleAndNormaliseIfNeeded(Number.parseInt(digit));
        }
      }
    );

    const sumOfDigits = numberWithDoubledDigits.reduce(
      (total: number = 0, digit: number) => {
        return total + digit;
      }
    );

    return sumOfDigits >= 10 && sumOfDigits % 10 == 0;
  }
}
