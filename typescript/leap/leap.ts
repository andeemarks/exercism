function isLeapYear( year: number ): boolean {
    let isCentury: boolean = year % 100 == 0;

    return isCentury ? (year % 400 == 0) : (year % 4 == 0);
}

export default isLeapYear