public static class Series
{
    public static string[] Slices(string numbers, int sliceLength)
    {
        if (sliceLength <= 0 || sliceLength > numbers.Length)
        {
            throw new ArgumentException();
        }

        var slices = new List<string>();

        for (var i = 0; i < numbers.Length - sliceLength + 1; i++)
        {
            slices.Add(new string(numbers.Substring(i, sliceLength)));
        }

        return [.. slices];
    }
}