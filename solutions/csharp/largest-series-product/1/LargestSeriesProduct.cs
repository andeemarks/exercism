
public static class LargestSeriesProduct
{
    public static List<string> GetSlidingSubstrings(string inputString, int substringLength)
    {
        List<string> substrings = new List<string>();

        // Handle edge cases: empty or null string, or length greater than input string
        if (string.IsNullOrEmpty(inputString) || substringLength <= 0 || substringLength > inputString.Length)
        {
            return substrings; // Return empty list
        }

        for (int i = 0; i <= inputString.Length - substringLength; i++)
        {
            substrings.Add(inputString.Substring(i, substringLength));
        }

        return substrings;
    }

    public static long GetLargestProduct(string digits, int span)
    {
        if (span > digits.Length || span < 0)
        {
            throw new ArgumentException();
        }

        if (digits.Length == 0)
        {
            return 1;
        }
        
        try
        {
            double.Parse(digits);
        }
        catch (Exception _e)
        {
            throw new ArgumentException();
        }

        var series = GetSlidingSubstrings(digits, span);
        var products = series.Select(s => CalcProduct(s));

        if (products.Count() == 0)
        {
            return 1;
        }

        return products.Max();
    }

    private static int CalcProduct(string series) {
        var digits = series.ToCharArray().Select(c => (int)Char.GetNumericValue(c)).ToList();

        return digits.Aggregate(1, (currentProduct, nextDigit) => currentProduct * nextDigit);
    }
}