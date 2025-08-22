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

        return string.Join("\n", Assemble(topHalf, bottomHalf));

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

    private static string[] BuildTopHalf(char target, int targetPos, string letters)
    {
        var alphaReversed = new string([.. letters.ToCharArray().Reverse()]);
        int width = targetPos * 2 - 1;
        var fullRow = alphaReversed + letters[1..];

        string[] topHalf = new string[targetPos];
        for (var i = 0; i < targetPos; i++)
        {
            var match = @"[^" + letters[i] + "]";
            topHalf[i] = Regex.Replace(fullRow, match, " ").Substring(letters.Length - targetPos, width);
        }

        return topHalf;
    }
}