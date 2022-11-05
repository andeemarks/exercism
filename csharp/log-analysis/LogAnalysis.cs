using System;

public static class LogAnalysis
{
    public static string SubstringAfter(this string str, string substr)
    {
        int substrStart = str.IndexOf(substr);

        return str.Substring(substrStart + substr.Length);
    }

    public static string SubstringBetween(this string str, string start, string end)
    {
        string strAfter = str.SubstringAfter(start);
        int substrStart = strAfter.IndexOf(end);

        return strAfter.Substring(0, substrStart);
    }

    public static string Message(this string str)
    {
        return str.SubstringAfter("]: ");
    }

    // TODO: define the 'LogLevel()' extension method on the `string` type
    public static string LogLevel(this string str)
    {
        return str.SubstringBetween("[", "]");
    }
}