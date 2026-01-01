using Xunit.Runner.Common;

public static class Alphametics
{
    public static IDictionary<char, int> Solve(string equation)
    {
        var (leftSide, rightSide) = ExtractSides(equation);

        var leftWords = leftSide.Split('+').Select(w => w.Trim()).ToArray();
        var rightWord = rightSide.Trim();

        var allWords = leftWords.Concat([rightWord]);
        var letterList = ExtractLettersFromWords(allWords);

        var leadingLetters = ExtractLeadingLettersFromWords(allWords);

        var assignment = new Dictionary<char, int>();
        var usedDigits = new HashSet<int>();

        return TryAssign(letterList, 0, assignment, usedDigits, leadingLetters, leftWords, rightWord)
            ? (IDictionary<char, int>)assignment
            : throw new ArgumentException("No solution found");
    }

    private static (string, string) ExtractSides(string equation)
    {
        var parts = equation.Split("==");

        return (parts[0].Trim(), parts[1].Trim());
    }

    private static HashSet<char> ExtractLeadingLettersFromWords(IEnumerable<string> allWords)
    {
        var leadingLetters = new HashSet<char>();
        foreach (var word in allWords)
        {
            if (word.Length > 1 && char.IsLetter(word[0]))
                leadingLetters.Add(word[0]);
        }

        return leadingLetters;
    }

    private static List<char> ExtractLettersFromWords(IEnumerable<string> allWords)
    {
        var letters = new HashSet<char>();
        foreach (var word in allWords)
        {
            foreach (var c in word)
            {
                if (char.IsLetter(c))
                    letters.Add(c);
            }
        }

        return [.. letters];
    }

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
            if (usedDigits.Contains(digit))
                continue;

            if (digit == 0 && leadingLetters.Contains(letter))
                continue;

            assignment[letter] = digit;
            usedDigits.Add(digit);

            if (TryAssign(letters, index + 1, assignment, usedDigits, leadingLetters, leftWords, rightWord))
            {
                return true;
            }

            assignment.Remove(letter);
            usedDigits.Remove(digit);
        }

        return false;
    }

    private static bool IsValidEquation(
        Dictionary<char, int> assignment,
        string[] leftWords,
        string rightWord)
    {
        long leftSum = 0;

        foreach (var word in leftWords)
        {
            long value = 0;
            foreach (var c in word)
            {
                if (char.IsLetter(c))
                {
                    value = value * 10 + assignment[c];
                }
            }
            leftSum += value;
        }

        long rightValue = 0;
        foreach (var c in rightWord)
        {
            if (char.IsLetter(c))
            {
                rightValue = rightValue * 10 + assignment[c];
            }
        }

        return leftSum == rightValue;
    }
}