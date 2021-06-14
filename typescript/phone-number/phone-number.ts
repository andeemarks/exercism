export default class PhoneNumber {
  constructor(readonly raw: string) {}

  private hasLetters(number: string): boolean {
    return (number.match(/[A-Za-z]/g) || []).length > 0;
  }

  private collectDigits(number: string): string {
    return number
      .split("")
      .filter((digit: string) => !isNaN(+digit))
      .join("");
  }

  private removeWhitespace(number: string): string {
    return number.replace(/\ /g, "");
  }

  private extractNumber(number: string): string | undefined {
    const MAX_VALID_NUMBER_LENGTH = 10;
    const VALID_COUNTRY_CODE = "1";

    if (number.length == MAX_VALID_NUMBER_LENGTH) {
      return number;
    }

    if (
      number.length == MAX_VALID_NUMBER_LENGTH + 1 &&
      number[0] == VALID_COUNTRY_CODE
    ) {
      return number.substring(1);
    }

    return;
  }

  number(): string | undefined {
    const trimmed = this.removeWhitespace(this.raw);

    if (this.hasLetters(trimmed)) {
      return;
    }

    const digits = this.collectDigits(trimmed);

    return this.extractNumber(digits);
  }
}
