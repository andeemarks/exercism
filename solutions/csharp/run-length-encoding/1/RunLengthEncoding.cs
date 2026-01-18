
using System.Text;

public static class RunLengthEncoding
{
    public static string Encode(string input)
    {
        var result = new StringBuilder();
        string current = "";
        int runLength = 0;
        foreach (char c in input)
        {
            if (current != c.ToString())
            {
                result.Append(runLength > 1 ? runLength.ToString() + current : current);
                current = c.ToString();
                runLength = 1;
            }
            else
            {
                runLength++;
            }
        }
        result.Append(runLength > 1 ? runLength.ToString() + current : current);

        return result.ToString();
    }

    public static string Decode(string input) => SplitInputByNumberBoundaries(input);

    private static string SplitInputByNumberBoundaries(string input) 
    {
        var i = 0;
        var result = new StringBuilder();
        while (i < input.Length)
        {
            char current = input[i];
            if (char.IsDigit(current))
            {
                if (char.IsDigit(input[i + 1]))
                {
                    result.Append(ExpandRun(input, i, 2));
                    i += 3;
                }
                else {
                    result.Append(ExpandRun(input, i, 1));
                    i += 2;
                }
            }
            else
            {
                result.Append(current);
                i++;
            }
        }
        return result.ToString();
    }

    private static string ExpandRun(string input, int i, int runLengthSize)
    {
        int runLength = int.Parse(input.Substring(i, runLengthSize));
        char character = input[i + runLengthSize];

        return new string(character, runLength);
    }
}
