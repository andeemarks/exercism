public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        var uniqueChars = word
            .ToLowerInvariant()
            .Where(c => char.IsLetter(c))
            .Distinct();

        var chars = word
            .ToLowerInvariant()
            .Where(c => char.IsLetter(c));

        return chars.Count() == uniqueChars.Count();
    }
}
