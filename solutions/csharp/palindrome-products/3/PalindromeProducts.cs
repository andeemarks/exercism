using System.ComponentModel;

public static class PalindromeProducts
{
    public static (int, IEnumerable<(int,int)>) Largest(int minFactor, int maxFactor)
    {
        var palindromeProducts = GetProducts(minFactor, maxFactor);

        var largest = palindromeProducts.Keys.Max();
        return (largest, palindromeProducts[largest]);
    }

    private static Dictionary<int, IEnumerable<(int, int)>> GetProducts(int minFactor, int maxFactor)
    {
        var palindromeProducts = new Dictionary<int, IEnumerable<(int, int)>>();
        for (var i = minFactor; i <= maxFactor; i++)
        {
            for (var j = i; j <= maxFactor; j++)
            {
                var product = (i * j).ToString();
                var digits = product.ToCharArray();
                Array.Reverse(digits);
                if (new string(digits) == product)
                {
                    var currentFactors = palindromeProducts.GetValueOrDefault(i * j, []);
                    currentFactors = currentFactors.Append((i, j));
                    palindromeProducts[i * j] = currentFactors;
                }
            }
        }

        if (palindromeProducts.Count == 0)
        {
            throw new ArgumentException();
        }

        return palindromeProducts;
    }

    public static (int, IEnumerable<(int, int)>) Smallest(int minFactor, int maxFactor)
    {
        var palindromeProducts = GetProducts(minFactor, maxFactor);
        
        var smallest = palindromeProducts.Keys.Min();
        return (smallest, palindromeProducts[smallest]);
    }
}
