using System;
using System.Text;

public static class Identifier
{
    public static string Clean(string identifier)
    {
        StringBuilder cleanString = new StringBuilder();
        int i = 0;
        char[] chars = identifier.ToCharArray();
        while (i < chars.Length)
        {
            char c = chars[i++];
            if (isGreekLowercase(c))
            {
                // omit
            }
            else if (Char.IsLetter(c))
            {
                cleanString.Append(c);
            }
            else if (Char.IsWhiteSpace(c))
            {
                cleanString.Append("_");
            }
            else if (Char.IsControl(c))
            {
                cleanString.Append("CTRL");
            }
            else if (c == '-')
            {
                cleanString.Append(Char.ToUpper(chars[i++]));
            }
        }

        return cleanString.ToString();
    }

    private static bool isGreekLowercase(char c) => c >= '\u03B1' && c <= '\u03C9';
}
