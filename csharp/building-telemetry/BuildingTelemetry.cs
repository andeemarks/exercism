using System;

public class RemoteControlCar
{
    private int batteryPercentage = 100;
    private int distanceDrivenInMeters = 0;
    private string[] sponsors = new string[0];
    private int latestSerialNum = 0;

    public void Drive()
    {
        if (batteryPercentage > 0)
        {
            batteryPercentage -= 10;
            distanceDrivenInMeters += 2;
        }
    }

    public void SetSponsors(params string[] sponsors)
    {
        this.sponsors = sponsors;
    }

    public string DisplaySponsor(int sponsorNum)
    {
        return sponsors[sponsorNum];
    }

    public bool GetTelemetryData(ref int serialNum,
        out int batteryPercentage, out int distanceDrivenInMeters)
    {
        if (serialNum > this.latestSerialNum)
        {
            this.latestSerialNum = serialNum;
            batteryPercentage = this.batteryPercentage;
            distanceDrivenInMeters = this.distanceDrivenInMeters;

            return true;
        }
        else
        {
            serialNum = this.latestSerialNum;
            batteryPercentage = -1;
            distanceDrivenInMeters = -1;

            return false;
        }
    }

    public static RemoteControlCar Buy()
    {
        return new RemoteControlCar();
    }
}

public class TelemetryClient
{
    private RemoteControlCar car;

    public TelemetryClient(RemoteControlCar car)
    {
        this.car = car;
    }

    public string GetBatteryUsagePerMeter(int serialNum)
    {
        int batteryPercentage, distanceDrivenInMeters;
        bool result = this.car.GetTelemetryData(ref serialNum, out batteryPercentage, out distanceDrivenInMeters);
        if (result == true && distanceDrivenInMeters > 0)
        {
            return $"usage-per-meter={(100 - batteryPercentage) / distanceDrivenInMeters}";
        }
        else
        {
            return "no data";
        }
    }
}