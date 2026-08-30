public class Clock
{
    private const int MINUTES_IN_HOUR = 60;
    private const int HOURS_IN_DAY = 24;

    public Clock(int hours, int minutes)
    {
        this.hours = hours;
        this.minutes = minutes;
    }

    public int hours { get; set; }
    public int minutes { get; }

    public Clock Add(int minutesToAdd)
    {
        return new Clock(this.hours, this.minutes + minutesToAdd);
    }

    public Clock Subtract(int minutesToSubtract)
    {
        return new Clock(this.hours, this.minutes - minutesToSubtract);
    }

    public override String ToString()
    {
        var rolledMinutes = this.minutes % MINUTES_IN_HOUR;
        int rolledHours;
        if (rolledMinutes < 0)
        {
            rolledHours = (this.hours - 1 - Math.Abs(this.minutes / MINUTES_IN_HOUR)) % HOURS_IN_DAY;
            rolledMinutes = MINUTES_IN_HOUR + rolledMinutes;
        } else
        {
            rolledHours = (this.hours + (this.minutes / MINUTES_IN_HOUR)) % HOURS_IN_DAY;
        }

        if (rolledHours < 0)
        {
            rolledHours = HOURS_IN_DAY + rolledHours;
        }

        return $"{rolledHours.ToString("D2")}:{rolledMinutes.ToString("D2")}";
    }

    public override bool Equals(object? obj)
    {
        if (obj == null)
        {
            return false;
        }

        return String.Equals(this.ToString(), obj.ToString());
    }

    public override int GetHashCode()
    {
        throw new NotImplementedException();
    }
}
