using CoordPair = ((int, int), (int, int));

public class WordSearch(string grid)
{
    public string grid { get; } = grid;

    public Dictionary<string, CoordPair?> Search(string[] wordsToSearchFor)
    {
        var results = new Dictionary<string, CoordPair?>();
        var lines = grid.Split();
        var columns = BuildColumns(lines);

        foreach (var word in wordsToSearchFor)
        {
            results[word] = null;
            FindWordInLines(results, word, lines);
            FindWordInColumns(results, word, columns);
            FindWordInDiagonals(results, word);
        }

        return results;
    }

    private void FindWordInColumns(Dictionary<string, CoordPair?> results, string word, string[] columns)
    {
        foreach (var column in columns.Select((chars, columnNumber) => new { columnNumber, chars }))
        {
            FindWordInString(results, word, word, column.columnNumber + 1, column.chars, T2BCoordMapper);
            FindWordInString(results, ReverseWord(word), word, column.columnNumber + 1, column.chars, B2TCoordMapper);
        }
    }

    private void FindWordInLines(Dictionary<string, CoordPair?> results, string word, string[] lines)
    {
        foreach (var line in lines.Select((chars, lineNumber) => new { lineNumber, chars }))
        {
            FindWordInString(results, word, word, line.lineNumber + 1, line.chars, L2RCoordMapper);
            FindWordInString(results, ReverseWord(word), word, line.lineNumber + 1, line.chars, R2LCoordMapper);
        }
    }

    private void FindWordInDiagonals(Dictionary<string, CoordPair?> results, string word)
    {
        FindWordInDiagonals(results, word, word, 1, T2BL2RMapper);
        FindWordInDiagonals(results, word, word, -1, T2BR2LMapper);

        var reversedWord = ReverseWord(word);
        FindWordInDiagonals(results, reversedWord, word, 1, B2TR2LCoordMapper);
        FindWordInDiagonals(results, reversedWord, word, -1, B2TL2RCoordMapper);
    }

    private static string[] BuildColumns(string[] lines)
    {
        var columns = new List<string>();
        for (var i = 0; i < lines[0].Length; i++)
        {
            var column = "";
            for (var j = 0; j < lines.Length; j++)
            {
                column += lines[j][i];

            }
            columns.Add(column);
        }

        return [.. columns];
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

    private static void FindWordInString(Dictionary<string, CoordPair?> results, string word, string label, int lineNumber, string line, Func<int, int, int, CoordPair> mapper)
    {
        var wordStart = line.IndexOf(word);
        if (wordStart >= 0)
        {
            results[label] = mapper(lineNumber, wordStart, word.Length);

        }
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

    private CoordPair B2TCoordMapper(int lineNumber, int wordStart, int wordLength)
    {
        return ((lineNumber, wordStart + wordLength), (lineNumber, wordStart + 1));
    }
    private CoordPair T2BCoordMapper(int lineNumber, int wordStart, int wordLength)
    {
        return ((lineNumber, wordStart + 1), (lineNumber, wordStart + wordLength));
    }

    private CoordPair L2RCoordMapper(int lineNumber, int wordStart, int wordLength)
    {
        return ((wordStart + 1, lineNumber), (wordStart + wordLength, lineNumber));
    }

    private CoordPair R2LCoordMapper(int lineNumber, int wordStart, int wordLength)
    {
        return ((wordStart + wordLength, lineNumber), (wordStart + 1, lineNumber));
    }

    private static string ReverseWord(string word)
    {
        var reversedWord = word.ToCharArray();
        Array.Reverse(reversedWord);

        return new string(reversedWord);
    }

}