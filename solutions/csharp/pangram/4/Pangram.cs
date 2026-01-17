public static class Pangram
{
    public static bool IsPangram(string input)
    {
        var uniqueLetters = GatherUniqueLetters(input);
        var alphabet = "abcdefghijklmnopqrstuvwxyz";

        return uniqueLetters.Count == alphabet.Length;
    }

    private static List<char> GatherUniqueLetters(string input)
    {
        // var uniqueLetters = new HashSet<char>();
        var uniqueLetters = input.Where(char.IsLetter).Select(char.ToLower).Distinct();

        return [.. uniqueLetters];
    }
}
