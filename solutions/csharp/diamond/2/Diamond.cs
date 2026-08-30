using System.ComponentModel;
using System.Text.RegularExpressions;

public static class Diamond
{
    public static string Make(char target)
    {
        var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        int finalLetterPos = Array.IndexOf(letters.ToCharArray(), target) + 1;
        var topHalf = BuildTopHalf(target, finalLetterPos, letters);
        var bottomHalf = BuildBottomHalf(finalLetterPos, topHalf);
        var diamond = Assemble(topHalf, bottomHalf);

        return string.Join("\n", diamond);

    }

    private static string[] Assemble(string[] topHalf, string[] bottomHalf)
    {
        var diamond = new string[topHalf.Length + bottomHalf.Length];
        Array.Copy(topHalf, 0, diamond, 0, topHalf.Length);
        Array.Copy(bottomHalf, 0, diamond, topHalf.Length, bottomHalf.Length);

        return diamond;
    }

    private static string[] BuildBottomHalf(int targetPos, string[] topHalf) =>
            [.. topHalf[..(targetPos - 1)].Reverse()];

    private static string[] BuildTopHalf(char target, int finalLetterPos, string letters)
    {
        var alphaReversed = new string([.. letters.ToCharArray().Reverse()]);
        int width = finalLetterPos * 2 - 1;
        var fullRow = alphaReversed + letters[1..];

        string[] topHalf = new string[finalLetterPos];
        for (var i = 0; i < finalLetterPos; i++)
        {
            var currentLetter = letters[i];
            var match = @"[^" + currentLetter + "]";
            topHalf[i] = Regex.Replace(fullRow, match, " ").Substring(letters.Length - finalLetterPos, width);
        }

        return topHalf;
    }
}