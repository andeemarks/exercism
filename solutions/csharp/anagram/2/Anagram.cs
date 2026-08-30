public class Anagram
{
    public Anagram(string baseWord)
    {
        OriginalWord = baseWord;
    }

    public string OriginalWord { get; }

    public string[] FindAnagrams(string[] potentialMatches)
    {
        var BaseWord = OriginalWord.ToLower().ToCharArray();
        Array.Sort(BaseWord);
        var anagrams = new List<string>();

        foreach (var word in potentialMatches)
        {
            var wordLetters = word.ToLower().ToCharArray();
            Array.Sort(wordLetters);

            if (BaseWord.SequenceEqual(wordLetters) && !String.Equals(OriginalWord, word, StringComparison.OrdinalIgnoreCase))
            {
                anagrams.Add(word);
            }
        }
        return [.. anagrams];
    }
}