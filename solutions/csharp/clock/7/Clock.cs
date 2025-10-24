public class Clock(int hours, int minutes)
{
    private const int MINUTES_IN_HOUR = 60;
    private const int HOURS_IN_DAY = 24;

    public int hours { get; } = hours;
    public int minutes { get; } = minutes;

    public Clock Add(int minutesToAdd) => new(this.hours, this.minutes + minutesToAdd);

    public Clock Subtract(int minutesToSubtract) => this.Add(-minutesToSubtract);

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
        return obj != null && String.Equals(this.ToString(), obj.ToString());
    }

    public override int GetHashCode() => throw new NotImplementedException();
}
