using System;
using System.Collections.Generic;

public static class PythagoreanTriplet
{
    public static IEnumerable<(int a, int b, int c)> TripletsWithSum(int sum)
    {
        var c = sum % 2 == 0 ? sum / 2 - 1 : (sum - 1) / 2;
        var b = c - 1;
        var a = sum - c - b;

        var results = new List<(int, int, int)>();
        while (HasValidTripletSizes(a, b, c))
        {
            while (!IsPythagoreanTriplet(a, b, c))
            {
                b--;
                a = sum - c - b;

                if (HaveExhaustedCombinations(a, b, c))
                {
                    return results;
                }

                if (!HasValidTripletSizes(a, b, c))
                {
                    (a, b, c) = ResetValues(sum, a, b, c);
                }
            }

            results.Add((a, b, c));
            (a, b, c) = ResetValues(sum, a, b, c);
        }
        return results.Count > 0 ? results : Array.Empty<(int, int, int)>();
    }

    private static Tuple<int, int, int> ResetValues(int sum, int a, int b, int c)
    {
        c--;
        b = c - 1;
        a = sum - c - b;

        return new Tuple<int, int, int>(a, b, c);
    }

    private static bool IsPythagoreanTriplet(int a, int b, int c) => (a * a) + (b * b) == (c * c);

    private static bool HasValidTripletSizes(int a, int b, int c) => a < b && b < c;
    private static bool HaveExhaustedCombinations(int a, int b, int c) => a <= 0 || b <= 0 || c <= 0;
}