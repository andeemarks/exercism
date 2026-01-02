using Xunit.Runner.Common;

public static class Alphametics
{
    public static IDictionary<char, int> Solve(string equation)
    {
        var (leftSide, rightSide) = ExtractSidesFromEquation(equation);

        var operands = leftSide.Split('+').Select(w => w.Trim()).ToArray();
        var sum = rightSide.Trim();

        var allWords = operands.Concat([sum]);
        var letterList = ExtractLettersFromWords(allWords);

        var leadingLetters = ExtractLeadingLettersFromWords(allWords);

        var assignment = new Dictionary<char, int>();
        var usedDigits = new HashSet<int>();

        return TryAssign(letterList, 0, assignment, usedDigits, leadingLetters, operands, sum)
            ? (IDictionary<char, int>)assignment
            : throw new ArgumentException("No solution found");
    }

    private static (string, string) ExtractSidesFromEquation(string equation)
    {
        var parts = equation.Split("==");

        return (parts[0].Trim(), parts[1].Trim());
    }

    private static HashSet<char> ExtractLeadingLettersFromWords(IEnumerable<string> words) =>
        [.. words.Where(word => word.Length > 1 && char.IsLetter(word[0])).Select(word => word[0])];

    private static List<char> ExtractLettersFromWords(IEnumerable<string> words) =>
        [.. words.SelectMany(word => word).Distinct()];

    private static bool TryAssign(
        List<char> letters,
        int index,
        Dictionary<char, int> assignment,
        HashSet<int> usedDigits,
        HashSet<char> leadingLetters,
        string[] leftWords,
        string rightWord)
    {
        if (index == letters.Count)
        {
            return IsValidEquation(assignment, leftWords, rightWord);
        }

        var letter = letters[index];

        for (int digit = 0; digit <= 9; digit++)
        {
            var isDigitUnused = !usedDigits.Contains(digit);
            var isNotLeadingLetter = (digit != 0 || !leadingLetters.Contains(letter));
            if (isDigitUnused && isNotLeadingLetter)
            {
                assignment[letter] = digit;
                usedDigits.Add(digit);

                if (TryAssign(letters, index + 1, assignment, usedDigits, leadingLetters, leftWords, rightWord))
                {
                    return true;
                }

                assignment.Remove(letter);
                usedDigits.Remove(digit);
            }
        }

        return false;
    }

    private static bool IsValidEquation( Dictionary<char, int> assignment, string[] leftWords, string rightWord)
    {
        var lhsValue = leftWords.Sum(word => WordToValue(assignment, word));
        var rhsValue = WordToValue(assignment, rightWord);

        return lhsValue == rhsValue;
    }

    private static long WordToValue(Dictionary<char, int> assignment, string word) =>
        word.Where(char.IsLetter) .Aggregate(0L, (value, c) => value * 10 + assignment[c]);
}