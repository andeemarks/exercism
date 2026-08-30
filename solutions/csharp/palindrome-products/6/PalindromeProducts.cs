using System.Collections.Concurrent;

using Factors = System.Collections.Generic.IEnumerable<(int, int)>;

public static class PalindromeProducts
{
    public static (int, Factors) Largest(int minFactor, int maxFactor)
    {
        var palindromeProducts = GetProducts(minFactor, maxFactor);

        var largest = palindromeProducts.Keys.Max();
        return (largest, palindromeProducts[largest]);
    }

    private static Dictionary<int, Factors> GetProducts(int minFactor, int maxFactor)
    {
        var palindromeProducts = new Dictionary<int, Factors>();
        for (var i = minFactor; i <= maxFactor; i++)
        {
            for (var j = i; j <= maxFactor; j++)
            {
                if (IsPalindrome(i * j))
                {
                    var currentFactors = palindromeProducts.GetValueOrDefault(i * j, []);
                    currentFactors = currentFactors.Append((i, j));
                    palindromeProducts[i * j] = currentFactors;
                }
            }
        }

        return palindromeProducts.Count > 0 ? palindromeProducts : throw new ArgumentException();
    }

    private static bool IsPalindrome(int product)
    {
        var productString = product.ToString();
        var digits = productString.ToCharArray();
        Array.Reverse(digits);

        return new string(digits) == productString;

    }
    public static (int, Factors) Smallest(int minFactor, int maxFactor)
    {
        var palindromeProducts = GetProducts(minFactor, maxFactor);

        var smallest = palindromeProducts.Keys.Min();
        return (smallest, palindromeProducts[smallest]);
    }
}
