public class Anagram
{
    public Anagram(string baseWord)
    {
        OriginalWord = baseWord;
    }

    public string OriginalWord { get; }

    public string[] FindAnagrams(string[] potentialMatches)
    {
        var originalWordLetters = SortedLetters(OriginalWord);

        var anagrams = new List<string>();

        foreach (var word in potentialMatches)
        {
            var wordLetters = SortedLetters(word);

            var isWordSameAsOriginal = String.Equals(OriginalWord, word, StringComparison.OrdinalIgnoreCase);
            if (originalWordLetters.SequenceEqual(wordLetters) && !isWordSameAsOriginal)
            {
                anagrams.Add(word);
            }
        }
        return [.. anagrams];
    }

    private char[] SortedLetters(string word)
    {
        var originalWordLetters = word.ToLower().ToCharArray();
        Array.Sort(originalWordLetters);

        return originalWordLetters;
    }
}