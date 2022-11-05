using System;

static class AssemblyLine
{
    public static double SuccessRate(int speed)
    {
        if (speed >= 1 && speed <= 4)
        {
            return 1;
        }
        if (speed >= 5 && speed <= 8)
        {
            return .9;
        }
        if (speed == 9)
        {
            return .8;
        }
        if (speed == 10)
        {
            return .77;
        }
        return 0;
    }

    public static double ProductionRatePerHour(int speed)
    {
        return SuccessRate(speed) * 221 * speed;
    }

    public static int WorkingItemsPerMinute(int speed)
    {
        return (int)(ProductionRatePerHour(speed) / 60);
    }
}
