const Bands = {
  black: 0,
  brown: 1,
  red: 2,
  orange: 3,
  yellow: 4,
  green: 5,
  blue: 6,
  violet: 7,
  grey: 8,
  white: 9,
};

export class ResistorColorTrio {
  constructor([colour1, colour2, colour3]) {
    this.checkForValidColours(colour1, colour2, colour3);

    this.value =
      (Bands[colour1] * 10 + Bands[colour2]) * Math.pow(10, Bands[colour3]);

    this.unit = "ohms";
    if (this.value >= 1000) {
      this.unit = "kilo" + this.unit;
      this.value = this.value / 1000;
    }
    this.label = `Resistor value: ${this.value} ${this.unit}`;
  }

  checkForValidColours = (colour1, colour2, colour3) => {
    if (!(colour1 in Bands && colour2 in Bands && colour3 in Bands)) {
      throw Error("invalid color");
    }
  };
}
