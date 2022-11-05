using System;

public static class Bob
{
    private static bool IsQuestion(this string statement) => statement.Trim().EndsWith("?");
    private static bool IsEmpty(this string statement) => statement.Trim().Length == 0;
    private static bool IsYelled(this string statement) => !statement.IsEmpty() && statement.ToUpper().Equals(statement) && !statement.ToLower().Equals(statement);

    public static string Response(string statement)
    {
        if (statement.IsYelled() && statement.IsQuestion())
        {
            return "Calm down, I know what I'm doing!";
        }

        if (statement.IsYelled())
        {
            return "Whoa, chill out!";
        }

        if (statement.IsQuestion())
        {
            return "Sure.";
        }

        if (statement.IsEmpty())
        {
            return "Fine. Be that way!";
        }

        return "Whatever.";
    }
}