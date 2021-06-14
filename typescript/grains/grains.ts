type SquareNumber = number;

function isSquareNumber(n: SquareNumber): n is SquareNumber {
  return n > 0 && n <= 64;
}

class Grains {
  static total(): number {
    return Array.from(Array(65).keys()).reduce(
      (sum, squareNumber) => sum + this.square(squareNumber)
    );
  }
  static square(squareNumber: number): any {
    if (isSquareNumber(squareNumber)) {
      return Math.pow(2, squareNumber - 1);
    } else {
      throw new Error("Input has wrong format");
    }
  }
}

export default Grains;
