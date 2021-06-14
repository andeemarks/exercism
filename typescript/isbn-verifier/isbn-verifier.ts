type ISBNDigits = Array<number>;

class ISBN {
  private valid: boolean;
  private rawDigits: Array<string>;

  private extractRawDigits(candidate: string): Array<string> {
    this.rawDigits = candidate.match(/[\d]/g) || [];
    if (candidate[candidate.length - 1] == "X") {
      this.rawDigits[this.rawDigits.length] = "10";
    }

    return this.rawDigits;
  }

  private isISBNFormat(candidate: string): boolean {
    let nonSuffixChars =
      candidate
        .toLowerCase()
        .substr(0, candidate.length - 1)
        .match(/[a-z]/g) || [];
    if (nonSuffixChars.length > 0) {
      return false;
    }

    return this.rawDigits.length === 10 || this.rawDigits.length === 9;
  }

  private multiplyDigits(digits: Array<string>): ISBNDigits {
    return digits.map((d, i) => {
      return (digits.length - i) * parseInt(d, 10);
    });
  }

  private sumDigits(digits: ISBNDigits): number {
    return digits.reduce((total, d) => {
      return total + d;
    });
  }

  constructor(candidate: string) {
    this.rawDigits = this.extractRawDigits(candidate);
    if (this.isISBNFormat(candidate)) {
      const sum = this.sumDigits(this.multiplyDigits(this.rawDigits));
      this.valid = sum % 11 === 0;
    } else {
      this.valid = false;
    }
  }

  isValid(): boolean {
    return this.valid;
  }
}

export default ISBN;
