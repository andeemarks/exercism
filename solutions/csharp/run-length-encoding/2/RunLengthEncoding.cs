
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
                result.Append(EncodeRun(current, runLength));
                current = c.ToString();
                runLength = 1;
            }
            else
            {
                runLength++;
            }
        }
        result.Append(EncodeRun(current, runLength));

        return result.ToString();
    }

    private static string EncodeRun(string current, int runLength) => runLength > 1 ? runLength.ToString() + current : current;
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
                    result.Append(DecodeRun(input, i, 2));
                    i += 3;
                }
                else {
                    result.Append(DecodeRun(input, i, 1));
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

    private static string DecodeRun(string input, int i, int runLengthSize)
    {
        int runLength = int.Parse(input.Substring(i, runLengthSize));
        char character = input[i + runLengthSize];

        return new string(character, runLength);
    }
}
