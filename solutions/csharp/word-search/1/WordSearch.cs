using System.Diagnostics;
using System.Linq;

public class WordSearch
{
    public WordSearch(string grid) => this.grid = grid;

    public string grid { get; }

    public Dictionary<string, ((int, int), (int, int))?> Search(string[] wordsToSearchFor)
    {
        var finds = new Dictionary<string, ((int, int), (int, int))?>();

        foreach (var word in wordsToSearchFor)
        {
            var lines = grid.Split();
            FindWordInLines(finds, word, lines);
            FindWordInColumns(finds, word, lines);
            FindWordInDiagonalsT2BL2R(finds, word, grid);
            FindWordInDiagonalsB2TR2L(finds, word, grid);
            FindWordInDiagonalsB2TL2R(finds, word, grid);
            FindWordInDiagonalsT2BR2L(finds, word, grid);
            
            if (!finds.ContainsKey(word))
            {
                finds.Add(word, null);
            }
        }

        return finds;
    }

    private void FindWordInDiagonalsT2BL2R(Dictionary<string, ((int, int), (int, int))?> finds, string word, string grid)
    {
        var lines = grid.Split();
        var allLetters = grid.Replace("\n", "");
        var lineLength = lines[0].Length;
        var wordLength = word.Length;
        var letterOffset = lineLength + 1;
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

                if (!finds.ContainsKey(word) && wordFound)
                {
                    finds.Add(word, ((lineNumber + 1, colNumber + 1), (lineNumber + wordLength, colNumber + wordLength)));
                }
            }
            else
            {
                currentLetterPos = allLetters.Length;
            }
        }

    }

    private void FindWordInDiagonalsT2BR2L(Dictionary<string, ((int, int), (int, int))?> finds, string word, string grid)
    {
        var lines = grid.Split();
        var allLetters = grid.Replace("\n", "");
        var lineLength = lines[0].Length;
        var wordLength = word.Length;
        var letterOffset = lineLength - 1;
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

                if (!finds.ContainsKey(word) && wordFound)
                {
                    finds.Add(word, ((colNumber + 1, lineNumber + 1), (colNumber + 1 - wordLength + 1, lineNumber + wordLength)));
                }
            }
            else
            {
                currentLetterPos = allLetters.Length;
            }
        }

    }

    private void FindWordInDiagonalsB2TR2L(Dictionary<string, ((int, int), (int, int))?> finds, string word, string grid)
    {
        var reversedWord = word.ToCharArray();
        Array.Reverse(reversedWord);
        var target = new string(reversedWord);

        var lines = grid.Split();
        var allLetters = grid.Replace("\n", "");
        var lineLength = lines[0].Length;
        var wordLength = word.Length;
        var letterOffset = lineLength + 1;
        var currentLetterPos = 0;

        while (currentLetterPos < allLetters.Length)
        {
            var wordStartPos = allLetters.IndexOf(target[0], currentLetterPos);

            if (wordStartPos >= 0)
            {
                currentLetterPos = wordStartPos + 1;
                var lineNumber = Math.DivRem(wordStartPos, lineLength, out int colNumber);
                var wordFound = true;

                var currentFindPos = wordStartPos + letterOffset;

                for (var i = 1; i < wordLength && wordFound; i++)
                {
                    if (currentFindPos < allLetters.Length && allLetters[currentFindPos] == target[i])
                    {
                        currentFindPos += letterOffset;
                    }
                    else
                    {
                        wordFound = false;
                    }
                }

                if (!finds.ContainsKey(word) && wordFound)
                {
                    finds.Add(word, ((colNumber + wordLength, lineNumber + wordLength), (colNumber + 1, lineNumber + 1)));
                }
            }
            else
            {
                currentLetterPos = allLetters.Length;
            }
        }

    }

    private void FindWordInDiagonalsB2TL2R(Dictionary<string, ((int, int), (int, int))?> finds, string word, string grid)
    {
        var reversedWord = word.ToCharArray();
        Array.Reverse(reversedWord);
        var target = new string(reversedWord);

        var lines = grid.Split();
        var allLetters = grid.Replace("\n", "");
        var lineLength = lines[0].Length;
        var wordLength = word.Length;
        var letterOffset = lineLength - 1;
        var currentLetterPos = 0;

        while (currentLetterPos < allLetters.Length)
        {
            var wordStartPos = allLetters.IndexOf(target[0], currentLetterPos);

            if (wordStartPos >= 0)
            {
                currentLetterPos = wordStartPos + 1;
                var lineNumber = Math.DivRem(wordStartPos, lineLength, out int colNumber);
                var wordFound = true;

                var currentFindPos = wordStartPos + letterOffset;

                for (var i = 1; i < wordLength && wordFound; i++)
                {
                    if (currentFindPos < allLetters.Length && allLetters[currentFindPos] == target[i])
                    {
                        currentFindPos += letterOffset;
                    }
                    else
                    {
                        wordFound = false;
                    }
                }

                if (!finds.ContainsKey(word) && wordFound)
                {
                    finds.Add(word, ((colNumber + 1 - wordLength + 1, lineNumber + wordLength), (colNumber + 1, lineNumber + 1)));
                }
            }
            else
            {
                currentLetterPos = allLetters.Length;
            }
        }

    }

    private static void FindWordInColumns(Dictionary<string, ((int, int), (int, int))?> finds, string word, string[] lines)
    {
        var lineNumber = 1;
        for (var column = 0; column < lines[0].Length; column++)
        {
            var rowLine = "";
            for (var row = 0; row < lines.Length; row++)
            {
                rowLine += lines[row][column];

            }
            FindWordT2B(finds, word, lineNumber, rowLine);
            FindWordB2T(finds, word, lineNumber, rowLine);
            lineNumber++;
        }
    }

    private static void FindWordInLines(Dictionary<string, ((int, int), (int, int))?> finds, string word, string[] lines)
    {
        var lineNumber = 1;
        foreach (var line in lines)
        {
            FindWordL2R(finds, word, lineNumber, line);
            FindWordR2L(finds, word, lineNumber, line);
            lineNumber++;
        }
    }

    private static void FindWordB2T(Dictionary<string, ((int, int), (int, int))?> finds, string word, int lineNumber, string rowLine)
    {
        var reversedWord = word.ToCharArray();
        Array.Reverse(reversedWord);
        var wordStart = rowLine.IndexOf(new string(reversedWord));
        if (wordStart >= 0)
        {
            finds.Add(word, ((lineNumber, wordStart + word.Length), (lineNumber, wordStart + 1)));

        }
    }

    private static void FindWordT2B(Dictionary<string, ((int, int), (int, int))?> finds, string word, int lineNumber, string rowLine)
    {
        var wordStart = rowLine.IndexOf(word);
        if (wordStart >= 0)
        {
            finds.Add(word, ((lineNumber, wordStart + 1), (lineNumber, wordStart + word.Length)));

        }
    }

    private static void FindWordR2L(Dictionary<string, ((int, int), (int, int))?> finds, string word, int lineNumber, string line)
    {
        var reversedWord = word.ToCharArray();
        Array.Reverse(reversedWord);
        var wordStart = line.IndexOf(new string(reversedWord));
        if (wordStart >= 0)
        {
            finds.Add(word, ((wordStart + word.Length, lineNumber), (wordStart + 1, lineNumber)));

        }
    }

    private static void FindWordL2R(Dictionary<string, ((int, int), (int, int))?> finds, string word, int lineNumber, string line)
    {
        var wordStart = line.IndexOf(word);
        if (wordStart >= 0)
        {
            finds.Add(word, ((wordStart + 1, lineNumber), (wordStart + word.Length, lineNumber)));

        }
    }
}