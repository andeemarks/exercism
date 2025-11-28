public static class AllYourBase
{
    public static int[] Rebase(int inputBase, int[] inputDigits, int outputBase)
    {
        ValidateArgs(inputBase, inputDigits, outputBase);

        var outputDigits = DigitsToTargetBase(inputBase, inputDigits);

        var wholeOutput = outputDigits.Sum();

        if (wholeOutput == 0)
        {
            return [0];
        }

        return SplitOutput(wholeOutput, outputBase);
    }

    private static int[] DigitsToTargetBase(int inputBase, int[] inputDigits)
    {
        var outputDigits = new int[inputDigits.Length];
        Array.Reverse(inputDigits);
        for (var i = 0; i < inputDigits.Length; i++)
        {
            outputDigits[i] = inputDigits[i] * (int)Math.Pow(inputBase, i);
        }

        return outputDigits;
    }

    private static void ValidateArgs(int inputBase, int[] inputDigits, int outputBase)
    {
        if (inputBase <= 1 || outputBase <= 1)
        {
            throw new ArgumentException();
        }

        if (inputDigits.Any(d => d < 0 || d >= inputBase))
        {
            throw new ArgumentException();
        }
    }

    private static int[] SplitOutput(int output, int outputBase)
    {
        List<int> listOfInts = [];
        while(output > 0)
        {
            listOfInts.Add(output % outputBase);
            output /= outputBase;
        }
        listOfInts.Reverse();

        return [.. listOfInts];
    }
}