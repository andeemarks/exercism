class Die {
  private sides: number;

  public constructor(sides: number) {
    this.sides = sides;
  }

  public roll(): number {
    return Math.floor(Math.random() * this.sides);
  }
}

class Dice {
  private die: Die;

  public constructor(die: Die) {
    this.die = die;
  }

  public rollTimes(count: number): Array<number> {
    var rolls = new Array(count);
    for (var rollNumber = 0; rollNumber < count; rollNumber++) {
      rolls[rollNumber] = this.die.roll();
    }
    return rolls;
  }
}

export class DnDCharacter {
  readonly constitution = DnDCharacter.generateAbilityScore();
  readonly strength = DnDCharacter.generateAbilityScore();
  readonly dexterity = DnDCharacter.generateAbilityScore();
  readonly intelligence = DnDCharacter.generateAbilityScore();
  readonly wisdom = DnDCharacter.generateAbilityScore();
  readonly charisma = DnDCharacter.generateAbilityScore();
  readonly hitpoints = 10 + DnDCharacter.getModifierFor(this.constitution);

  private static roll4D6(): Array<number> {
    return new Dice(new Die(6)).rollTimes(4);
  }

  private static sumOf3HighestRolls(rolls: Array<number>): number {
    var min = Math.min(...rolls);
    var largestThree = rolls.filter((roll) => roll != min);

    return largestThree.reduce((sum, roll) => (sum += roll), 0);
  }

  public static generateAbilityScore(): number {
    return this.sumOf3HighestRolls(this.roll4D6());
  }

  public static getModifierFor(abilityValue: number): number {
    return Math.floor((abilityValue - 10) / 2);
  }
}
