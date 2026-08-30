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
                if (IsPrime(i))
                {
                    primes.Add(i);
                    if (AllFactorsFound(primes, number))
                    {
                        return [.. primes];
                    }
                }

                remainder = ExhaustFactor(primes, remainder, i);
            }
        }

        return [.. primes];
    }

    private static bool AllFactorsFound(List<long> primes, long target)
    {
        return primes.Aggregate(1L, (currentProduct, prime) => currentProduct * prime) == target;
    }

    private static long ExhaustFactor(List<long> primes, long remainder, int factor)
    {
        var isFactor = true;
        remainder /= factor;
        while (isFactor)
        {
            if (remainder % factor == 0)
            {
                primes.Add(factor);
                remainder /= factor;
            }
            else
            {
                isFactor = false;
            }
        }

        return remainder;
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
