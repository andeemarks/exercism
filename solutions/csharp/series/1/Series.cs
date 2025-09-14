public static class Series
{
    public static string[] Slices(string numbers, int sliceLength)
    {
        if (sliceLength <= 0 || sliceLength > numbers.Length)
        {
            throw new ArgumentException();
        }
        
        var slices = new List<string>();
        var digits = numbers.ToCharArray();

        for (var i = 0; i < digits.Length - sliceLength + 1; i++)
        {
            slices.Add(new string(digits[i..(i + sliceLength)]));
        }

        return [.. slices];
    }
}