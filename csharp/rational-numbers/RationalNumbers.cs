using System;
using System.Diagnostics;
using System.Numerics;

public static class RealNumberExtension
{
    public static double Expreal(this int realNumber, RationalNumber r)
    {
        return NthRoot(Math.Pow(realNumber, r.numerator), r.denominator);
    }

    // https://stackoverflow.com/questions/18657508/c-sharp-find-nth-root
    static double NthRoot(double A, int N)
    {
        return Math.Pow(A, 1.0 / N);
    }
}

public struct RationalNumber
{
    public readonly int numerator;
    public readonly int denominator;

    public RationalNumber(int numerator, int denominator)
    {
        if (denominator < 0)
        {
            this.numerator = -numerator;
            this.denominator = numerator == 0 ? 1 : -denominator;
        }
        else
        {
            this.numerator = numerator;
            this.denominator = numerator == 0 ? 1 : denominator;
        }
    }

    public static RationalNumber operator +(RationalNumber r1, RationalNumber r2)
    {
        var newDenominator = r1.denominator * r2.denominator;
        var newNumerator = (r1.numerator * r2.denominator) + (r1.denominator * r2.numerator);

        return new RationalNumber(newNumerator, newDenominator);
    }

    public static RationalNumber operator -(RationalNumber r1, RationalNumber r2)
    {
        var newDenominator = r1.denominator * r2.denominator;
        var newNumerator = (r1.numerator * r2.denominator) - (r1.denominator * r2.numerator);

        return new RationalNumber(newNumerator, newDenominator);
    }

    public static RationalNumber operator *(RationalNumber r1, RationalNumber r2)
    {
        var newDenominator = r1.denominator * r2.denominator;
        var newNumerator = (r1.numerator * r2.numerator);

        return new RationalNumber(newNumerator, newDenominator).Reduce();
    }

    public static RationalNumber operator /(RationalNumber r1, RationalNumber r2)
    {
        var newDenominator = r1.denominator * r2.numerator;
        var newNumerator = (r1.numerator * r2.denominator);

        return new RationalNumber(newNumerator, newDenominator);
    }

    public RationalNumber Abs()
    {
        var newDenominator = Math.Abs(denominator);
        var newNumerator = Math.Abs(numerator);

        return new RationalNumber(newNumerator, newDenominator).Reduce();
    }

    public RationalNumber Reduce()
    {
        var gcd = BigInteger.GreatestCommonDivisor(new BigInteger(numerator), new BigInteger(denominator));

        return new RationalNumber(numerator / (int)gcd, denominator / (int)gcd);
    }

    public RationalNumber Exprational(int power)
    {
        if (power >= 0)
        {
            return new RationalNumber((int)Math.Pow(numerator, power), (int)Math.Pow(denominator, power));
        }
        else
        {
            return new RationalNumber((int)Math.Pow(denominator, -power), (int)Math.Pow(numerator, -power));

        }

    }
}