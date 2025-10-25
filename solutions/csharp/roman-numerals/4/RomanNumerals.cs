using System.Diagnostics;

public static class RomanNumeralExtension
{
    private static Dictionary<int, string> digitMappings = new Dictionary<int, string>
    {
        {0, ""},
        {1, "I"},
        {2, "II"},
        {3, "III"},
        {4, "IV"},
        {5, "V"},
        {6, "VI"},
        {7, "VII"},
        {8, "VIII"},
        {9, "IX"},
        {10, "X"},
    };

    public static string ToRoman(this int value)
    {
        if (value >= 1000)
        {
            return MapThousands(value);
        }
        else if (value >= 100)
        {
            return MapHundreds(value);
        }
        else
        {
            return value >= 10 ? MapTens(value) : digitMappings[value];
        }
    }

    private static string MapTens(int value)
    {
        var tens = value / 10;
        var digits = digitMappings[value % 10];

        switch (tens)
        {
            case 0:
                return $"{digits}";
            case 4:
                return $"XL{digits}";
            case 5:
                return $"L{digits}";
            case 6:
                return $"LX{digits}";
            case 7:
                return $"LXX{digits}";
            case 8:
                return $"LXXX{digits}";
            case 9:
                return $"XC{digits}";
            default:
                return $"{new String('X', tens)}{digits}";
        }
    }
    private static string MapHundreds(int value)
    {
        var hundreds = value / 100;
        var tens = MapTens(value - (hundreds * 100));

        switch (hundreds)
        {
            case 1:
                return $"C{tens}";
            case 4:
                return $"CD{tens}";
            case 5:
                return $"D{tens}";
            case 6:
                return $"DC{tens}";
            case 7:
                return $"DCC{tens}";
            case 8:
                return $"DCCC{tens}";
            case 9:
                return $"CM{tens}";
            default:
                return tens;
        }

    }
    private static string MapThousands(int value)
    {
        var thousands = value / 1000;
        var hundreds = MapHundreds(value - (thousands * 1000));

        return $"{new String('M', thousands)}{hundreds}";

    }
}