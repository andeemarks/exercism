class EquationComponents
{
    public List<char> letterList { get; }
    public HashSet<char> leadingLetters { get; }
    public string[] operands { get; }
    public string sum { get; }

    public EquationComponents(string equation)
    {
        var (leftSide, rightSide) = ExtractSidesFromEquation(equation);
        operands = leftSide.Split('+').Select(w => w.Trim()).ToArray();
        sum = rightSide.Trim();
        var allWords = operands.Concat([sum]);
        letterList = ExtractLettersFromWords(allWords);
        leadingLetters = ExtractLeadingLettersFromWords(allWords);
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
}

public static class Alphametics
{
    public static IDictionary<char, int> Solve(string equation)
    {
        var components = new EquationComponents(equation);
        // var (leftSide, rightSide) = ExtractSidesFromEquation(equation);
        // var operands = leftSide.Split('+').Select(w => w.Trim()).ToArray();
        // var sum = rightSide.Trim();
        // var allWords = operands.Concat([sum]);
        // var letterList = ExtractLettersFromWords(allWords);
        // var leadingLetters = ExtractLeadingLettersFromWords(allWords);
        var assignment = new Dictionary<char, int>();
        var usedDigits = new HashSet<int>();

        return TryAssign(components, assignment, usedDigits)
            ? (IDictionary<char, int>)assignment
            : throw new ArgumentException("No solution found");
    }


    private static bool TryAssign(
        EquationComponents equation,
        Dictionary<char, int> assignment,
        HashSet<int> usedDigits,
        int index = 0)
    {
        if (index == equation.letterList.Count)
        {
            return IsValidEquation(assignment, equation.operands, equation.sum);
        }

        var letter = equation.letterList[index];

        for (int digit = 0; digit <= 9; digit++)
        {
            var isDigitUnused = !usedDigits.Contains(digit);
            var isNotLeadingLetter = digit != 0 || !equation.leadingLetters.Contains(letter);
            if (isDigitUnused && isNotLeadingLetter)
            {
                assignment[letter] = digit;
                usedDigits.Add(digit);

                if (TryAssign(equation, assignment, usedDigits, index + 1))
                {
                    return true;
                }

                assignment.Remove(letter);
                usedDigits.Remove(digit);
            }
        }

        return false;
    }

    private static bool IsValidEquation( Dictionary<char, int> assignment, string[] operands, string sum)
    {
        var lhsValue = operands.Sum(word => WordToValue(assignment, word));
        var rhsValue = WordToValue(assignment, sum);

        return lhsValue == rhsValue;
    }

    private static long WordToValue(Dictionary<char, int> assignment, string word) =>
        word.Where(char.IsLetter) .Aggregate(0L, (value, c) => value * 10 + assignment[c]);
}