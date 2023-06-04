using System;

public static class CentralBank
{
    public static string DisplayDenomination(long @base, long multiplier)
    {
        try
        {
            checked
            {
                return $"{@base * multiplier}";
            }
        }
        catch (OverflowException)
        {
            return "*** Too Big ***";
        }
    }

    public static string DisplayGDP(float @base, float multiplier)
    {
        var GDP = @base * multiplier;
        if (float.IsInfinity(GDP))
        {
            return "*** Too Big ***";
        }
        else
        {
            return $"{@base * multiplier}";
        }
    }

    public static string DisplayChiefEconomistSalary(decimal salaryBase, decimal multiplier)
    {
        try
        {
            checked
            {
                return $"{salaryBase * multiplier}";
            }
        }
        catch (OverflowException)
        {
            return "*** Much Too Big ***";
        }
    }
}
