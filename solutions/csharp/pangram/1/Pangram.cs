public static class Pangram
{
    public static bool IsPangram(string input)
    {
        var uniqueLetters = new HashSet<char>();
        foreach (var c in input)
        {
            if (char.IsLetter(c))
            {
                uniqueLetters.Add(char.ToLower(c));
            }
        }
        return uniqueLetters.Count == 26;
    }
}
