export default class ArmstrongNumbers {
    static isArmstrongNumber(n: number): boolean {
        const digits: Array<number> = n.toString().split('').map( (digit: string) => Number(digit));
        const power: number = digits.length;

        let sum: number = 0;
        digits.forEach( ( digit: number ) => sum += Math.pow(digit, power));

        return sum === n;
    }
}