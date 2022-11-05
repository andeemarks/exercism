using System;

static class SavingsAccount
{
    public static float InterestRate(decimal balance)
    {
        if (balance >= 0 && balance < 1000)
        {
            return 0.5f;
        }
        if (balance >= 1000 && balance < 5000)
        {
            return 1.621f;
        }
        if (balance < 0)
        {
            return 3.213f;
        }
        if (balance >= 5000)
        {
            return 2.475f;
        }

        return 0f;
    }

    public static decimal Interest(decimal balance) => (decimal)InterestRate(balance) * balance / 100;

    public static decimal AnnualBalanceUpdate(decimal balance)
    {
        return balance + Interest(balance);
    }

    public static int YearsBeforeDesiredBalance(decimal balance, decimal targetBalance)
    {
        int year = 0;
        decimal cumulativeBalance = balance;
        do
        {
            cumulativeBalance = AnnualBalanceUpdate(cumulativeBalance);
            year++;
        } while (cumulativeBalance < targetBalance);

        return year;
    }
}
