export default class Anagram {
  constructor(readonly word: string) {}

  private normalise(input: string): string {
    return input.toLowerCase().split("").sort().join("");
  }

  private hasSameLetters(s1: string, s2: string): boolean {
    return this.normalise(s1) == this.normalise(s2);
  }

  private equalsIgnoreCase(s1: string, s2: string): boolean {
    return s1.toLowerCase() == s2.toLowerCase();
  }

  public matches(...options: string[]): string[] {
    let anagrams = options.filter(
      (option: string) =>
        this.hasSameLetters(option, this.word) &&
        !this.equalsIgnoreCase(option, this.word)
    );

    return anagrams;
  }
}
