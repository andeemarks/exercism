public static class Pangram
{
    public static bool IsPangram(string input)
    {
        var uniqueLetters = GatherUniqueLetters(input);
        var alphabet = "abcdefghijklmnopqrstuvwxyz";

        return uniqueLetters.Count() == alphabet.Length;
    }

    private static IEnumerable<char> GatherUniqueLetters(string input)
    {
        return input.Where(char.IsLetter).Select(char.ToLower).Distinct();
    }
}
