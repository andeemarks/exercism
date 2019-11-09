function isLeapYear( year: number ): boolean {
    if (year % 4 == 0) {
        let isCentury: boolean = year % 100 == 0;

        return isCentury ? (year % 400 == 0) : truetermi;
    } else {
        return false;
    }
}

export default isLeapYear