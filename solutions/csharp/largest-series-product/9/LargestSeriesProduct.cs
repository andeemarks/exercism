
public static class LargestSeriesProduct
{
    public static List<string> GetSlidingSubstrings(string inputString, int substringLength)
    {
        List<string> substrings = [];

        for (int i = 0; i <= inputString.Length - substringLength; i++)
        {
            substrings.Add(inputString.Substring(i, substringLength));
        }

        return substrings;
    }

    public static long GetLargestProduct(string digits, int span)
    {
        try
        {
            ValidateInput(digits, span);
        }
        catch (FormatException)
        {
            return 1;
        }

        var series = GetSlidingSubstrings(digits, span);
        var products = series.Select(s => CalcProduct(s));

        return products.Max();
    }

    private static void ValidateInput(string digits, int span)
    {
        if (span > digits.Length || span < 0)
        {
            throw new ArgumentException();
        }

        if (digits.Length == 0)
        {
            throw new FormatException();
        }

        try
        {
            double.Parse(digits);
        }
        catch (Exception)
        {
            throw new ArgumentException();
        }
    }

    private static int CalcProduct(string series) {
        var digits = series.ToCharArray().Select(c => (int)Char.GetNumericValue(c)).ToList();

        return digits.Aggregate(1, (currentProduct, nextDigit) => currentProduct * nextDigit);
    }
}