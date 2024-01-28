export class Robot {
  static nameCache: Set<string> = new Set();
  constructor() {
    this.resetName();
  }

  private _name: string = "";

  public get name(): string {
    return this._name;
  }

  private randomLetter(): string {
    const LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return LETTERS[Math.floor(Math.random() * LETTERS.length)];
  }

  private randomDigit(): number {
    const DIGITS = Array.from(Array(10).keys());

    return DIGITS[Math.floor(Math.random() * DIGITS.length)];
  }

  private generateName(): string {
    return `${this.randomLetter()}${this.randomLetter()}${this.randomDigit()}${this.randomDigit()}${this.randomDigit()}`;
  }

  public resetName(): void {
    var newName = this.generateName();
    while (Robot.nameCache.has(newName)) {
      newName = this.generateName();
    }

    Robot.nameCache.add(newName);
    this._name = newName;
  }

  public static releaseNames(): void {
    this.nameCache = new Set();
  }
}
