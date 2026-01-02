class EquationComponents
{
    public List<char> Letters { get; }
    public HashSet<char> LeadingLetters { get; }
    public string[] Operands { get; }
    public string Sum { get; }

    public EquationComponents(string equation)
    {
        var (leftSide, rightSide) = ExtractSidesFromEquation(equation);
        Operands = [.. leftSide.Split('+').Select(w => w.Trim())];
        Sum = rightSide.Trim();
        var allWords = Operands.Concat([Sum]);
        Letters = ExtractLettersFromWords(allWords);
        LeadingLetters = ExtractLeadingLettersFromWords(allWords);
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
        var assignment = new Dictionary<char, int>();
        var usedDigits = new HashSet<int>();

        return TryAssign(components, assignment, usedDigits)
            ? (IDictionary<char, int>)assignment
            : throw new ArgumentException("No solution found");
    }


    private static bool TryAssign( EquationComponents equation, Dictionary<char, int> assignment, HashSet<int> usedDigits, int index = 0)
    {
        if (index == equation.Letters.Count)
        {
            return IsValidEquation(assignment, equation);
        }

        var letter = equation.Letters[index];

        for (int digit = 0; digit <= 9; digit++)
        {
            var isDigitUnused = !usedDigits.Contains(digit);
            var isNotLeadingLetter = digit != 0 || !equation.LeadingLetters.Contains(letter);
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

    private static bool IsValidEquation( Dictionary<char, int> assignment, EquationComponents equation)
    {
        var lhsValue = equation.Operands.Sum(word => WordToValue(assignment, word));
        var rhsValue = WordToValue(assignment, equation.Sum);

        return lhsValue == rhsValue;
    }

    private static long WordToValue(Dictionary<char, int> assignment, string word) =>
        word.Where(char.IsLetter) .Aggregate(0L, (value, c) => value * 10 + assignment[c]);
}