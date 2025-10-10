public static class PascalsTriangle
{
    public static IEnumerable<IEnumerable<int>> Calculate(int rows)
    {
        if (rows == 0)
        {
            return [];
        }

        var result = new List<List<int>>
        {
            ([1])
        };

        if (rows > 1)
        {
            for (var i = 1; i < rows; i++)
            {
                var previousRow = result[i - 1];
                var newRow = ComputeNewRow(previousRow);
                result.Add(newRow);
            }
        }

        return (IEnumerable<IEnumerable<int>>)result;
    }

    private static List<int> ComputeNewRow(List<int> previousRow)
    {
        var newRow = new List<int> { 1 };
        for (var j = 0; j < previousRow.Count - 1; j++)
        {
            newRow.Add(previousRow[j] + previousRow[j + 1]);
        }
        newRow.Add(1);        

        return newRow;
    }
}