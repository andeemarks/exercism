using System;

class RemoteControlCar
{
    private readonly int speed;
    private readonly int batteryDrain;

    private int distanceDriven = 0;
    private int batteryRemaining = 100;

    // TODO: define the constructor for the 'RemoteControlCar' class
    public RemoteControlCar(int speed, int batteryDrain)
    {
        this.speed = speed;
        this.batteryDrain = batteryDrain;
    }

    public bool BatteryDrained()
    {
        return this.batteryRemaining < this.batteryDrain;
    }

    public int DistanceDriven()
    {
        return this.distanceDriven;
    }

    public void Drive()
    {
        if (!this.BatteryDrained())
        {
            this.batteryRemaining -= this.batteryDrain;
            this.distanceDriven += speed;
        }
    }

    public static RemoteControlCar Nitro()
    {
        return new RemoteControlCar(50, 4);
    }
}

class RaceTrack
{
    private readonly int distance;

    public RaceTrack(int distance)
    {
        this.distance = distance;
    }

    public bool TryFinishTrack(RemoteControlCar car)
    {
        do
        {
            car.Drive();
        } while (car.DistanceDriven() < this.distance && !car.BatteryDrained());

        return car.DistanceDriven() >= this.distance;
    }
}
