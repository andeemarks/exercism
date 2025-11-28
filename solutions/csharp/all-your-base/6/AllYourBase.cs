public static class AllYourBase
{
    public static int[] Rebase(int inputBase, int[] inputDigits, int outputBase)
    {
        ValidateArgs(inputBase, inputDigits, outputBase);

        var base10Digits = InputToBase10Digits(inputBase, inputDigits);

        return Base10DigitsToOutputBaseDigits(outputBase, base10Digits);
    }

    private static int[] Base10DigitsToOutputBaseDigits(int outputBase, int[] base10Digits)
    {
        var wholeOutput = base10Digits.Sum();

        if (wholeOutput == 0)
        {
            return [0];
        }

        List<int> listOfInts = [];
        while(wholeOutput > 0)
        {
            listOfInts.Add(wholeOutput % outputBase);
            wholeOutput /= outputBase;
        }
        listOfInts.Reverse();

        return [.. listOfInts];
    }

    private static int[] InputToBase10Digits(int inputBase, int[] inputDigits)
    {
        var base10Digits = new int[inputDigits.Length];
        Array.Reverse(inputDigits);
        for (var i = 0; i < inputDigits.Length; i++)
        {
            base10Digits[i] = inputDigits[i] * (int)Math.Pow(inputBase, i);
        }

        return base10Digits;
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Usage", "CA2208:Instantiate argument exceptions correctly", Justification = "<Pending>")]
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
}