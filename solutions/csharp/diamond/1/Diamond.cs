using System.ComponentModel;
using System.Text.RegularExpressions;

public static class Diamond
{
    public static string Make(char target)
    {
        var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var alphaReversed = new string(alpha.ToCharArray().Reverse().ToArray());
        int targetPos = Array.IndexOf(alpha.ToCharArray(), target) + 1;
        int diamondHeight = targetPos * 2 - 1;
        int diamondWidth = diamondHeight;
        string[] topHalf = new string[targetPos];
        var fullRow = alphaReversed + alpha[1..];
        for (var i = 0; i < targetPos; i++)
        {
            var currentLetter = alpha[i];
            var match = @"[^" + currentLetter + "]";
            topHalf[i] = Regex.Replace(fullRow, match, " ").Substring(alpha.Length - targetPos, diamondWidth);
        }

        var bottomHalf = topHalf[..(targetPos - 1)].Reverse().ToArray();
        var diamond = new string[topHalf.Length + bottomHalf.Length];
        Array.Copy(topHalf, 0, diamond, 0, topHalf.Length);
        Array.Copy(bottomHalf, 0, diamond, topHalf.Length, bottomHalf.Length);

        return string.Join("\n", diamond);
        
    }
}