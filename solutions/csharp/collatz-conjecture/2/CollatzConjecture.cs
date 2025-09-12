using Xunit.Sdk;

public static class CollatzConjecture
{
    public static int Steps(int number)
    {
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(number);

        var steps = 0;
        var result = number;

        while (result != 1)
        {
            result = AdjustResult(result);
            steps++;
        }

        return steps;
    }

    private static int AdjustResult(int result)
    {
        return result % 2 == 0 ? result / 2 : result * 3 + 1;
    }
}