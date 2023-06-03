public class RemoteControlCar
{
    public string CurrentSponsor { get; private set; }

    private Speed currentSpeed;

    // TODO encapsulate the methods suffixed with "_Telemetry" in their own class
    // dropping the suffix from the method name

    public CarTelemetry Telemetry;

    public RemoteControlCar()
    {
        Telemetry = new CarTelemetry(this);
    }

    public class CarTelemetry
    {
        private RemoteControlCar Parent;

        public CarTelemetry(RemoteControlCar parent)
        {
            Parent = parent;
        }

        public void Calibrate()
        {

        }

        public bool SelfTest()
        {
            return true;
        }

        public void ShowSponsor(string sponsorName)
        {
            Parent.SetSponsor(sponsorName);
        }

        public void SetSpeed(decimal amount, string unitsString)
        {
            SpeedUnits speedUnits = SpeedUnits.MetersPerSecond;
            if (unitsString == "cps")
            {
                speedUnits = SpeedUnits.CentimetersPerSecond;
            }

            Parent.SetSpeed(new Speed(amount, speedUnits));
        }
    }

    public string GetSpeed()
    {
        return currentSpeed.ToString();
    }

    private void SetSponsor(string sponsorName)
    {
        CurrentSponsor = sponsorName;

    }

    private void SetSpeed(Speed speed)
    {
        currentSpeed = speed;
    }

    public struct Speed
    {
        public decimal Amount { get; }
        public SpeedUnits SpeedUnits { get; }

        public Speed(decimal amount, SpeedUnits speedUnits)
        {
            Amount = amount;
            SpeedUnits = speedUnits;
        }

        public override string ToString()
        {
            string unitsString = "meters per second";
            if (SpeedUnits == SpeedUnits.CentimetersPerSecond)
            {
                unitsString = "centimeters per second";
            }

            return Amount + " " + unitsString;
        }
    }


    public enum SpeedUnits
    {
        MetersPerSecond,
        CentimetersPerSecond
    }
}
