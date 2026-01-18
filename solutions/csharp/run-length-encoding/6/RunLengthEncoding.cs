
using System.Text;

public static class RunLengthEncoding
{
    public static string Encode(string input)
    {
        var result = new StringBuilder();
        string runChar = "";
        int runLength = 0;
        foreach (char c in input)
        {
            if (runChar != c.ToString())
            {
                result.Append(EncodeRun(runChar, runLength));
                runChar = c.ToString();
                runLength = 1;
            }
            else
            {
                runLength++;
            }
        }
        result.Append(EncodeRun(runChar, runLength));

        return result.ToString();
    }

    public static string Decode(string input) 
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

    private static string EncodeRun(string current, int runLength) => runLength > 1 ? $"{runLength.ToString()}{current}" : current;
    private static string DecodeRun(string input, int i, int runLengthSize)
    {
        int runLength = int.Parse(input.Substring(i, runLengthSize));
        char runChar = input[i + runLengthSize];

        return new string(runChar, runLength);
    }
}
