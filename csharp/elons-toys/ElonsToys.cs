using System;

class RemoteControlCar
{
    public int distance { get; private set; } = 0;
    public int battery_remaining { get; private set; } = 100;

    public static RemoteControlCar Buy()
    {
        return new RemoteControlCar();
    }

    public string DistanceDisplay()
    {
        return $"Driven {distance} meters";
    }

    public string BatteryDisplay()
    {
        return $"Battery {(battery_remaining <= 0 ? "empty" : $"at {battery_remaining}%")}";
    }

    public void Drive()
    {
        battery_remaining--;
        if (battery_remaining >= 0)
        {
            distance += 20;
        }
    }
}
