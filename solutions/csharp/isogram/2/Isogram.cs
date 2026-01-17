public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        var chars = word
            .ToLowerInvariant()
            .Where(c => char.IsLetter(c));

        var uniqueChars = chars
            .Distinct();

        return chars.Count() == uniqueChars.Count();
    }
}
