using System;

public struct CurrencyAmount
{
    private decimal amount;
    private string currency;

    public CurrencyAmount(decimal amount, string currency)
    {
        this.amount = amount;
        this.currency = currency;
    }

    public override bool Equals(object obj)
    {
        if (obj is CurrencyAmount other && !this.currency.Equals(other.currency))
        {
            throw new ArgumentException();
        }

        return obj is CurrencyAmount amount &&
               this.amount == amount.amount &&
               currency == amount.currency;
    }

    public override int GetHashCode()
    {
        return HashCode.Combine(amount, currency);
    }

    public static bool operator ==(CurrencyAmount a, CurrencyAmount b) => a.Equals(b);
    public static bool operator !=(CurrencyAmount a, CurrencyAmount b) => !(a == b);
    public static CurrencyAmount operator +(CurrencyAmount a, CurrencyAmount b)
    {
        checkForMatchingCurrencies(a, b);
        return new CurrencyAmount(a.amount + b.amount, a.currency);
    }
    public static CurrencyAmount operator -(CurrencyAmount a, CurrencyAmount b)
    {
        checkForMatchingCurrencies(a, b);
        return new CurrencyAmount(a.amount - b.amount, a.currency);
    }

    private static void checkForMatchingCurrencies(CurrencyAmount a, CurrencyAmount b)
    {
        if (!a.currency.Equals(b.currency))
        {
            throw new ArgumentException();
        }
    }

    public static CurrencyAmount operator *(decimal a, CurrencyAmount b) => new CurrencyAmount(a * b.amount, b.currency);
    public static CurrencyAmount operator *(CurrencyAmount a, decimal b) => new CurrencyAmount(a.amount * b, a.currency);
    public static decimal operator /(CurrencyAmount a, decimal b) => a.amount / b;
    public static bool operator <(CurrencyAmount a, CurrencyAmount b)
    {
        checkForMatchingCurrencies(a, b);
        return a.amount < b.amount;
    }
    public static bool operator >(CurrencyAmount a, CurrencyAmount b)
    {
        checkForMatchingCurrencies(a, b);
        return a.amount > b.amount;
    }

    public static implicit operator decimal(CurrencyAmount v) => v.amount;

    public static explicit operator double(CurrencyAmount v) => (double)v.amount;
}
