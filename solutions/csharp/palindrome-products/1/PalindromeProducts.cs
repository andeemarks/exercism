using System.ComponentModel;

public static class PalindromeProducts
{
    public static (int, IEnumerable<(int,int)>) Largest(int minFactor, int maxFactor)
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
                    if (palindromeProducts.ContainsKey(i * j))
                    {
                        var currentFactors = palindromeProducts[i * j];
                        currentFactors = currentFactors.Append((i, j));
                        palindromeProducts[i * j] = currentFactors;
                    }
                    else
                    {
                        palindromeProducts[i * j] = [(i, j)];
                    }
                }
            }
        }

        if (palindromeProducts.Count == 0)
        {
            throw new ArgumentException();
        }

        var largest = palindromeProducts.Keys.Max();
        return (largest, palindromeProducts[largest]);
    }

    public static (int, IEnumerable<(int, int)>) Smallest(int minFactor, int maxFactor)
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
                    if (palindromeProducts.ContainsKey(i * j))
                    {
                        var currentFactors = palindromeProducts[i * j];
                        currentFactors = currentFactors.Append((i, j));
                        palindromeProducts[i * j] = currentFactors;
                    }
                    else
                    {
                        palindromeProducts[i * j] = [(i, j)];
                    }
                }
            }
        }

        if (palindromeProducts.Count == 0)
        {
            throw new ArgumentException();
        }
        
        var smallest = palindromeProducts.Keys.Min();
        return (smallest, palindromeProducts[smallest]);
    }
}
