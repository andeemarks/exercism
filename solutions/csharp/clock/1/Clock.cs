public class Clock
{
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
        var rolledMinutes = this.minutes % 60;
        var rolledHours = 0;
        if (rolledMinutes < 0)
        {
            rolledHours = (this.hours - 1 - Math.Abs(this.minutes / 60)) % 24;
            rolledMinutes = 60 + rolledMinutes;
        } else
        {
            rolledHours = (this.hours + (this.minutes / 60)) % 24;
        }

        if (rolledHours < 0)
        {
            rolledHours = 24 + rolledHours;
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
}
