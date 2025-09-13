public class Anagram
{
    public Anagram(string baseWord)
    {
        OriginalWord = baseWord;
    }

    public string OriginalWord { get; }

    public string[] FindAnagrams(string[] potentialMatches)
    {
        return [.. potentialMatches.Where(IsAnagram)];
    }

    private bool IsAnagram(string word)
    {
        var originalWordLetters = OriginalWord.ToSortedLetters();
        var wordLetters = word.ToSortedLetters();
        var isWordSameAsOriginal = String.Equals(OriginalWord, word, StringComparison.OrdinalIgnoreCase);

        return originalWordLetters.SequenceEqual(wordLetters) && !isWordSameAsOriginal;
    }
}

public static class StringExtenstions
{
    public static char[] ToSortedLetters(this string word)
    {
        var originalWordLetters = word.ToLower().ToCharArray();
        Array.Sort(originalWordLetters);

        return originalWordLetters;
    }
}