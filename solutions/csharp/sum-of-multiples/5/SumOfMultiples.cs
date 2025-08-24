using System.Dynamic;
using System.Transactions;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        var factors = new HashSet<int>();

        foreach (var multiple in multiples.Where(m => m > 0 && m <= max))
        {
            factors = [.. factors, .. Range.From(multiple, max, multiple)];
        }
        return factors.Sum();
    }
}

public static class Range
{

    public static IEnumerable<int> From(int start, int stop, int step) => RangeIterator(start, stop, step);

    private static IEnumerable<int> RangeIterator(int start, int stop, int step)
    {
        int x = start;

        do
        {
            yield return x;
            x += step;
            if (step < 0 && x <= stop || 0 < step && stop <= x)
                break;
        }
        while (true);
    }

}