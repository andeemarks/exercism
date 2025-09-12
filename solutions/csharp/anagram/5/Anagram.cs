public class Anagram
{
    public Anagram(string baseWord)
    {
        OriginalWord = baseWord;
    }

    public string OriginalWord { get; }

    public string[] FindAnagrams(string[] potentialMatches)
    {
        var originalWordLetters = OriginalWord.SortedLetters();

        var anagrams = new List<string>();

        foreach (var word in potentialMatches)
        {
            var wordLetters = word.SortedLetters();

            var isWordSameAsOriginal = String.Equals(OriginalWord, word, StringComparison.OrdinalIgnoreCase);
            if (originalWordLetters.SequenceEqual(wordLetters) && !isWordSameAsOriginal)
            {
                anagrams.Add(word);
            }
        }
        return [.. anagrams];
    }
}

public static class StringExtenstions
{
    public static char[] SortedLetters(this string word)
    {
        var originalWordLetters = word.ToLower().ToCharArray();
        Array.Sort(originalWordLetters);

        return originalWordLetters;
    }
}