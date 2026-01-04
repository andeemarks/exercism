public static class DifferenceOfSquares
{
    public static int CalculateSquareOfSum(int max)
    {
        var sum = listToMax(max).Sum();

        return sum * sum;
    }

    public static int CalculateSumOfSquares(int max)
    {
        var rangeList = listToMax(max);

        return rangeList.Sum(n => n * n);
    }

    private static List<int> listToMax(int max)
    {
        var range = 1..max;

        return [.. Enumerable.Range(range.Start.Value, range.End.Value - range.Start.Value + 1)];
    }

    public static int CalculateDifferenceOfSquares(int max) => CalculateSquareOfSum(max) - CalculateSumOfSquares(max);
}