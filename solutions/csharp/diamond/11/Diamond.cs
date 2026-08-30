using System.ComponentModel;
using System.Text.RegularExpressions;


public static class Diamond
{
    private static readonly string LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    public static string Make(char target)
    {
        int targetLetterPos = Array.IndexOf(LETTERS.ToCharArray(), target) + 1;
        var topHalf = BuildTopHalf(targetLetterPos);
        var bottomHalf = BuildBottomHalf(targetLetterPos, topHalf);

        return Assemble(topHalf, bottomHalf);
    }

    private static string Assemble(string[] topHalf, string[] bottomHalf)
    {
        var diamond = new string[topHalf.Length + bottomHalf.Length];
        Array.Copy(topHalf, 0, diamond, 0, topHalf.Length);
        Array.Copy(bottomHalf, 0, diamond, topHalf.Length, bottomHalf.Length);

        return string.Join("\n", diamond);
    }

    private static string[] BuildBottomHalf(int targetPos, string[] topHalf) =>
            [.. topHalf[..(targetPos - 1)].Reverse()];

    private static string[] BuildTopHalf(int targetPos)
    {
        var lettersReversed = new string([.. LETTERS.ToCharArray().Reverse()]);
        int rowWidth = targetPos * 2 - 1;
        var row = (lettersReversed + LETTERS[1..]).Substring(LETTERS.Length - targetPos, rowWidth);

        string[] topHalf = new string[targetPos];
        for (var i = 0; i < targetPos; i++)
        {
            topHalf[i] = Regex.Replace(row, @"[^" + LETTERS[i] + "]", " ");
        }

        return topHalf;
    }
}