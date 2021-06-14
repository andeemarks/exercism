class Series {
  public readonly digits: Array<number>;

  constructor(series: string) {
    this.digits = series
      .split("")
      .map((digit: string) => Number.parseInt(digit));
  }

  slices(width: number): Array<Array<number>> {
    const numberOfDigits = this.digits.length;
    if (width > numberOfDigits) {
      throw new Error();
    }

    const numberOfSlices = numberOfDigits - width + 1;
    const sliceStarts = [...Array(numberOfSlices).keys()];

    return sliceStarts.map((sliceStart: number) =>
      this.digits.slice(sliceStart, sliceStart + width)
    );
  }
}

export default Series;
