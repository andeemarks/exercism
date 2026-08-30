using System.Dynamic;
using System.Transactions;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        var factors = new HashSet<int>();

        foreach (var multiple in multiples.Where(m => m > 0 && m <= max))
        {
            foreach (var i in Helpers.Range(multiple, max, multiple))
            {
                factors.Add(i);
            }
        }
        return factors.Sum();
    }
}

public static class Helpers
{
    
    public static IEnumerable<int> Range(int start, int stop, int step = 1)
    {
        if (step == 0)
            throw new ArgumentException(nameof(step));

        return RangeIterator(start, stop, step);
    }

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