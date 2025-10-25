using System.Diagnostics;

public static class RomanNumeralExtension
{
    private static Dictionary<int, string> basicMappings = new Dictionary<int, string>
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
        else if (value >= 10)
        {
            return MapTens(value);
        }
        else
        {
            return basicMappings[value];
        }
    }

    private static string MapTens(int value)
    {
        var tens = value / 10;
        var digits = value % 10;

        switch (tens)
        {
            case 0:
                return $"{basicMappings[digits]}";
            case 4:
                return $"XL{basicMappings[digits]}";
            case 5:
                return $"L{basicMappings[digits]}";
            case 6:
                return $"LX{basicMappings[digits]}";
            case 7:
                return $"LXX{basicMappings[digits]}";
            case 8:
                return $"LXXX{basicMappings[digits]}";
            case 9:
                return $"XC{basicMappings[digits]}";
            default:
                return $"{new String('X', tens)}{basicMappings[digits]}";
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