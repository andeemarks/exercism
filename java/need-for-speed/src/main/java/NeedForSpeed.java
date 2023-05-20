class NeedForSpeed {
    // TODO: define the constructor for the 'NeedForSpeed' class

    private int batteryDrain;
    private int speed;
    private int batteryCharge = 100;
    private int distanceDriven = 0;

    public NeedForSpeed(int speed, int batteryDrain) {
        this.batteryDrain = batteryDrain;
        this.speed = speed;
    }

    public boolean batteryDrained() {
        return this.batteryCharge <= 0;
    }

    public int distanceDriven() {
        return this.distanceDriven;
    }

    public void drive() {
        this.batteryCharge -= this.batteryDrain;
        if (this.batteryCharge >= 0) {
            this.distanceDriven += this.speed;
        }
    }

    public static NeedForSpeed nitro() {
        return new NeedForSpeed(50, 4);
    }
}

class RaceTrack {
    private int distance;

    public RaceTrack(int distance) {
        this.distance = distance;
    }

    public boolean tryFinishTrack(NeedForSpeed car) {
        while (car.distanceDriven() < this.distance && !car.batteryDrained()) {
            car.drive();
        }

        return car.distanceDriven() >= this.distance;
    }
}
