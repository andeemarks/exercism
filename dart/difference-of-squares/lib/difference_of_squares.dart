class DifferenceOfSquares {

  int sumOfSquares(int aNumber) {
    var values = List.generate(aNumber + 1, (i) => i);
    var sum = values.reduce((total, value) => total + value * value);

    return sum;
  }

  int differenceOfSquares(int aNumber) {
    return squareOfSum(aNumber) - sumOfSquares(aNumber);

  }

  int squareOfSum(int aNumber) {
    var values = List.generate(aNumber + 1, (i) => i);
    var sum = values.reduce((total, value) => total + value);

    return sum * sum;
  }
}
