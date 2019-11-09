export default class RotationalCipher {
  static rotate(plaintext: string, offset: number): string {
    return plaintext
      .split("")
      .map(letter => this.rotateLetter(letter, offset))
      .join("");
  }

  static rotateLetterFromBase(
    letter: string,
    offset: number,
    base: number
  ): string {
    const plainLetterOffset = letter.charCodeAt(0) - base;
    const cipherLetterOffset = base + ((plainLetterOffset + offset) % 26);

    return String.fromCharCode(cipherLetterOffset);
  }

  static rotateLetter(letter: string, offset: number): string {
    if (letter.match(/[a-z]/)) {
      return this.rotateLetterFromBase(letter, offset, "a".charCodeAt(0));
    } else if (letter.match(/[A-Z]/)) {
      return this.rotateLetterFromBase(letter, offset, "A".charCodeAt(0));
    }

    return letter;
  }
}
