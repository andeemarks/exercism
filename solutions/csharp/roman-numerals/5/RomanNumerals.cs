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

        return tens switch
        {
            0 => $"{digits}",
            4 => $"XL{digits}",
            5 => $"L{digits}",
            6 => $"LX{digits}",
            7 => $"LXX{digits}",
            8 => $"LXXX{digits}",
            9 => $"XC{digits}",
            _ => $"{new String('X', tens)}{digits}",
        };
    }
    private static string MapHundreds(int value)
    {
        var hundreds = value / 100;
        var tens = MapTens(value - (hundreds * 100));

        return hundreds switch
        {
            1 => $"C{tens}",
            4 => $"CD{tens}",
            5 => $"D{tens}",
            6 => $"DC{tens}",
            7 => $"DCC{tens}",
            8 => $"DCCC{tens}",
            9 => $"CM{tens}",
            _ => tens,
        };
    }
    private static string MapThousands(int value)
    {
        var thousands = value / 1000;
        var hundreds = MapHundreds(value - (thousands * 1000));

        return $"{new String('M', thousands)}{hundreds}";

    }
}