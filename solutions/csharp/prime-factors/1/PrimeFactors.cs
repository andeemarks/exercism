public static class PrimeFactors
{

    public static long[] Factors(long number)
    {
        var primes = new List<long>();

        var remainder = number;
        for (var i = 2; i <= number; i++)
        {
            if (remainder % i == 0)
            {
                var isFactor = true;
                if (IsPrime(i))
                {
                    primes.Add(i);
                    long primesProduct = primes.Aggregate(1L, (currentProduct, prime) => currentProduct * prime);
                    if (primesProduct == number)
                    {
                        return [.. primes];
                    }
                }
                remainder /= i;
                while (isFactor)
                {
                    if (remainder % i == 0)
                    {
                        primes.Add(i);
                        remainder /= i;
                    }
                    else
                    {
                        isFactor = false;
                    }
                }
            }
        }

        return [.. primes];
    }

    private static readonly List<long> primeCache = [];
    private static readonly List<long> subprimeCache = [];

    private static bool IsPrime(long n)
    {
        if (primeCache.Contains(n))
        {
            return true;
        }
        if (subprimeCache.Contains(n))
        {
            return false;
        }

        var isPrime = false;
        for (var i = 2; i <= n / 2; i++)
        {
            if (n % i == 0)
            {
                return isPrime;
            }
        }

        isPrime = n > 1;

        if (isPrime)
        {
            primeCache.Add(n);
        }
        else
        {
            subprimeCache.Add(n);
        }

        return isPrime;
    }
}
