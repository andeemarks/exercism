import { totalmem } from "os";
import { numberLiteralTypeAnnotation } from "@babel/types";

class Squares {
    squareOfSum: number;
    sumOfSquares: number;
    difference: number;

    constructor(size: number) {
        let numbers = Array.from(Array(size + 1).keys());
        this.sumOfSquares = numbers.reduce((total: number, value: number): number => total += (value ** 2));
        this.squareOfSum = numbers.reduce((total: number, value: number): number => total += value) ** 2;
        this.difference = this.squareOfSum - this.sumOfSquares;
    }

}

export default Squares