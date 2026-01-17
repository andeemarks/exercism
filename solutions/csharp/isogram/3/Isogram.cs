public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        var chars = word
            .ToLowerInvariant()
            .Where(char.IsLetter);

        var uniqueChars = chars
            .Distinct();

        return chars.Count() == uniqueChars.Count();
    }
}
