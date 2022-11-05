using System;

class BirdCount
{
    private int[] birdsPerDay;

    public BirdCount(int[] birdsPerDay)
    {
        this.birdsPerDay = birdsPerDay;
    }

    public static int[] LastWeek()
    {
        return new int[] { 0, 2, 5, 3, 7, 8, 4 };
    }

    public int Today()
    {
        return this.birdsPerDay[this.birdsPerDay.Length - 1];
    }

    public void IncrementTodaysCount()
    {
        this.birdsPerDay[this.birdsPerDay.Length - 1]++;
    }

    public bool HasDayWithoutBirds()
    {
        int daysWithoutBirds = 0;
        foreach (int dayCount in this.birdsPerDay)
        {
            if (dayCount == 0)
            {
                daysWithoutBirds++;
            }
        }

        return daysWithoutBirds > 0;
    }

    public int CountForFirstDays(int numberOfDays)
    {
        int sumOfDayCounts = 0;
        for (int i = 0; i < numberOfDays; i++)
        {
            sumOfDayCounts += this.birdsPerDay[i];
        }

        return sumOfDayCounts;
    }

    public int BusyDays()
    {
        int sumOfBusyDays = 0;
        foreach (int dayCount in this.birdsPerDay)
        {
            if (dayCount >= 5)
            {
                sumOfBusyDays++;
            }
        }

        return sumOfBusyDays;
    }
}
