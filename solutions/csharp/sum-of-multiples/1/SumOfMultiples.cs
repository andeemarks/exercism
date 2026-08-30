using System.Dynamic;
using System.Transactions;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        var factors = new HashSet<int>();

        foreach (var multiple in multiples.Where(m => m > 0))
        {
            var current = multiple;
            while (current < max)
            {
                factors.Add(current);

                current += multiple;

            }
        }
        return factors.Sum();
    }
}