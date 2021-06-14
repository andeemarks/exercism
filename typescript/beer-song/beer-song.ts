export default class Beer {
  static verse(i: number): string {
    if (i == 1) {
      return `1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.\n`;
    }

    if (i == 0) {
      return `No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.\n`;
    }

    let remainingBottlesPhrase: string =
      i <= 2 ? i - 1 + " bottle" : i - 1 + " bottles";

    return `${i} bottles of beer on the wall, ${i} bottles of beer.
Take one down and pass it around, ${remainingBottlesPhrase} of beer on the wall.\n`;
  }

  static sing(from: number = 99, to: number = 0): string {
    let song: string = "";
    for (let i = from; i >= to; i--) {
      song += this.verse(i) + "\n";
    }

    return song.replace(/\n$/, "");
  }
}
