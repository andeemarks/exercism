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
            if (result % 2 == 0)
            {
                result /= 2;
            }
            else
            {
                result = result * 3 + 1;
            }
            steps++;
        }

        return steps;
    }
}