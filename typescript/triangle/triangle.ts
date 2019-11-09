export default class Triangle {
  sides: number[];

  constructor(...sides: number[]) {
    this.sides = sides;
  }

  kind() {
    let positiveSides = this.sides.filter((side: number) => side <= 0);
    if (positiveSides.length > 0) {
      throw "all sides must be positive";
    }

    let sidesBySize = this.sides.sort(
      (side1: number, side2: number) => side1 - side2
    );
    if (sidesBySize[2] > sidesBySize[1] + sidesBySize[0]) {
      throw "sides do not describe a triangle";
    }

    let typeByUniqueCount = ["equilateral", "isosceles", "scalene"];
    let uniqueCount = new Set(this.sides).size - 1;

    return typeByUniqueCount[uniqueCount];
  }
}
