const MILLIS_IN_GS: number = Math.pow(10, 9) * 1000;

class Gigasecond {
    millisSinceBase: number;

    constructor(base: Date) {
        this.millisSinceBase = base.getTime();
    }

    date(): Date {
        return new Date(this.millisSinceBase + MILLIS_IN_GS);
    }
}

export default Gigasecond
