export default class Converter {
  convertToBase10(source: Array<number>, sourceBase: number): number {
    let sourceAsDecimal: number = 0;
    // source.reduce( (acc: number, n: number, i: number, source) => acc + (n * sourceBase ** (source.length - (i + 1))));
    for (let i = 0; i < source.length; i++) {
      sourceAsDecimal += source[i] * sourceBase ** (source.length - (i + 1));
    }

    return sourceAsDecimal;
  }

  findHighestTargetPower(sourceAsDecimal: number, targetBase: number): number {
    let highestTargetPowerFound: boolean = false;
    let highestTargetPower: number = 0;
    while (!highestTargetPowerFound) {
      if (targetBase ** highestTargetPower > sourceAsDecimal) {
        highestTargetPowerFound = true;
      } else {
        highestTargetPower++;
      }
    }

    return highestTargetPower - 1;
  }

  convertToTargetBase(
    sourceAsDecimal: number,
    highestTargetPower: number,
    targetBase: number
  ): Array<number> {
    let target: Array<number> = [];
    for (let i = highestTargetPower; i >= 0; i--) {
      let digit = Math.floor(sourceAsDecimal / targetBase ** i);
      target.push(digit);
      sourceAsDecimal -= digit * targetBase ** i;
    }

    return target;
  }

  validate(source: Array<number>, sourceBase: number, targetBase: number) {
    if (sourceBase <= 1) {
      throw new Error("Wrong input base");
    }

    const firstZeroInSource: number = source.findIndex(i => i === 0);
    if (
      firstZeroInSource >= 0 &&
      firstZeroInSource < source.findIndex(i => i > 0)
    ) {
      throw new Error("Input has wrong format");
    }

    if (targetBase <= 1 || targetBase != Math.round(targetBase)) {
      throw new Error("Wrong output base");
    }

    if (source.length === 0) {
      throw new Error("Input has wrong format");
    }

    if (source.filter(i => i < 0).length > 0) {
      throw new Error("Input has wrong format");
    }

    if (source.filter(i => i >= sourceBase).length > 0) {
      throw new Error("Input has wrong format");
    }

    if (
      source.length > 1 &&
      source.filter(i => i === 0).length === source.length
    ) {
      throw new Error("Input has wrong format");
    }
  }

  convert(
    source: Array<number>,
    sourceBase: number,
    targetBase: number
  ): Array<number> {
    this.validate(source, sourceBase, targetBase);

    let sourceAsDecimal: number = this.convertToBase10(source, sourceBase);

    if (sourceAsDecimal === 0) {
      return [0];
    }

    let highestTargetPower: number = this.findHighestTargetPower(
      sourceAsDecimal,
      targetBase
    );

    return this.convertToTargetBase(
      sourceAsDecimal,
      highestTargetPower,
      targetBase
    );
  }
}
