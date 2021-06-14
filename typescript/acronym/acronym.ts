type WordList = Array<string>;

export default class Acronym {
  public static parse(phrase: string): string {
    return this.toAcronym(this.words(phrase));
  }

  private static toAcronym(words: WordList): string {
    return words
      .map(word => {
        return this.firstLetterUppercased(word);
      })
      .join("");
  }

  private static firstLetterUppercased(word: string): string {
    return word.charAt(0).toUpperCase();
  }

  private static wordOrSubWords(word: string): string {
    const subwordRE = /[A-Z][a-z]+/g;
    const subWords = word.match(subwordRE);
    if (subWords && subWords!.length > 1) {
      return subWords.join(",");
    } else {
      return word;
    }
  }

  private static words(phrase: string): WordList {
    const wordRE = /[A-Za-z]+/g;
    const words = phrase.match(wordRE)!;
    return words
      .map(word => {
        return this.wordOrSubWords(word);
      })
      .toString()
      .split(",");
  }
}
