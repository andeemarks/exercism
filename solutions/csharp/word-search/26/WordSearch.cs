using System.Diagnostics;
using System.Linq;

using Microsoft.Testing.Platform.OutputDevice;

using CoordPair = ((int, int), (int, int));

public class WordSearch(string grid)
{
    public string grid { get; } = grid;

    public Dictionary<string, CoordPair?> Search(string[] wordsToSearchFor)
    {
        var results = new Dictionary<string, CoordPair?>();

        foreach (var word in wordsToSearchFor)
        {
            results[word] = null;
            var lines = grid.Split();
            FindWordInLines(results, word, lines);
            FindWordInColumns(results, word, lines);
            FindWordInDiagonals(results, word);
        }

        return results;
    }

    private void FindWordInDiagonals(Dictionary<string, CoordPair?> results, string word)
    {
        FindWordInDiagonals(results, word, word, 1, T2BL2RMapper);
        FindWordInDiagonals(results, word, word, -1, T2BR2LMapper);

        var reversedWord = ReverseWord(word);
        FindWordInDiagonals(results, reversedWord, word, 1, B2TR2LCoordMapper);
        FindWordInDiagonals(results, reversedWord, word, -1, B2TL2RCoordMapper);
    }

    private CoordPair T2BL2RMapper(int lineNumber, int colNumber, int wordLength)
    {
        return ((lineNumber + 1, colNumber + 1), (lineNumber + wordLength, colNumber + wordLength));
    }

    private CoordPair T2BR2LMapper(int lineNumber, int colNumber, int wordLength)
    {
        return ((colNumber + 1, lineNumber + 1), (colNumber + 1 - wordLength + 1, lineNumber + wordLength));
    }

    private CoordPair B2TR2LCoordMapper(int lineNumber, int colNumber, int wordLength)
    {
        return ((colNumber + wordLength, lineNumber + wordLength), (colNumber + 1, lineNumber + 1));
    }
    private CoordPair B2TL2RCoordMapper(int lineNumber, int colNumber, int wordLength)
    {
        return ((colNumber + 1 - wordLength + 1, lineNumber + wordLength), (colNumber + 1, lineNumber + 1));
    }

    private void FindWordInDiagonals(Dictionary<string, CoordPair?> results, string word, string label, int offset, Func<int, int, int, CoordPair> mapper)
    {
        var lines = grid.Split();
        var allLetters = grid.Replace("\n", "");
        var lineLength = lines[0].Length;
        var wordLength = word.Length;
        var letterOffset = lineLength + offset;
        var currentLetterPos = 0;

        while (currentLetterPos < allLetters.Length)
        {
            var wordStartPos = allLetters.IndexOf(word[0], currentLetterPos);

            if (wordStartPos >= 0)
            {
                currentLetterPos = wordStartPos + 1;
                var lineNumber = Math.DivRem(wordStartPos, lineLength, out int colNumber);
                var wordFound = true;

                var currentFindPos = wordStartPos + letterOffset;

                for (var i = 1; i < wordLength && wordFound; i++)
                {
                    if (currentFindPos < allLetters.Length && allLetters[currentFindPos] == word[i])
                    {
                        currentFindPos += letterOffset;
                    }
                    else
                    {
                        wordFound = false;
                    }
                }

                if (wordFound)
                {
                    results[label] = mapper(lineNumber, colNumber, wordLength);
                }
            }
            else
            {
                currentLetterPos = allLetters.Length;
            }
        }

    }

    private static string ReverseWord(string word)
    {
        var reversedWord = word.ToCharArray();
        Array.Reverse(reversedWord);

        return new string(reversedWord);
    }

    private void FindWordInColumns(Dictionary<string, CoordPair?> results, string word, string[] lines)
    {
        var lineNumber = 1;
        for (var column = 0; column < lines[0].Length; column++)
        {
            var rowLine = "";
            for (var row = 0; row < lines.Length; row++)
            {
                rowLine += lines[row][column];

            }
            FindWordVertically(results, word, word, lineNumber, rowLine, T2BCoordMapper);
            var reversedWord = ReverseWord(word);
            FindWordVertically(results, reversedWord, word, lineNumber, rowLine, B2TCoordMapper);
            lineNumber++;
        }
    }

    private CoordPair B2TCoordMapper(int lineNumber, int wordStart, int wordLength)
    {
        return ((lineNumber, wordStart + wordLength), (lineNumber, wordStart + 1));
    }
    private CoordPair T2BCoordMapper(int lineNumber, int wordStart, int wordLength)
    {
        return ((lineNumber, wordStart + 1), (lineNumber, wordStart + wordLength));
    }

    private static void FindWordInLines(Dictionary<string, CoordPair?> results, string word, string[] lines)
    {
        var lineNumber = 1;
        foreach (var line in lines)
        {
            FindWordL2R(results, word, word, lineNumber, line);
            var reversedWord = ReverseWord(word);
            FindWordR2L(results, reversedWord, word, lineNumber, line);
            lineNumber++;
        }
    }

    private static void FindWordVertically(Dictionary<string, CoordPair?> results, string word, string label, int lineNumber, string rowLine, Func<int, int, int, CoordPair> mapper)
    {
        var wordStart = rowLine.IndexOf(word);
        if (wordStart >= 0)
        {
            results[label] = mapper(lineNumber, wordStart, word.Length);

        }
    }

    private static void FindWordR2L(Dictionary<string, CoordPair?> results, string word, string label, int lineNumber, string line)
    {
        var wordStart = line.IndexOf(word);
        if (wordStart >= 0)
        {
            results[label] = ((wordStart + word.Length, lineNumber), (wordStart + 1, lineNumber));

        }
    }

    private static void FindWordL2R(Dictionary<string, CoordPair?> results, string word, string label, int lineNumber, string line)
    {
        var wordStart = line.IndexOf(word);
        if (wordStart >= 0)
        {
            results[label] = ((wordStart + 1, lineNumber), (wordStart + word.Length, lineNumber));

        }
    }
}