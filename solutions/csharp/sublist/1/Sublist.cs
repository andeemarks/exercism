public enum SublistType
{
    Equal,
    Unequal,
    Superlist,
    Sublist
}

public static class Sublist
{
    public static SublistType Classify<T>(List<T> list1, List<T> list2)
        where T : IComparable
    {
        if (list1.SequenceEqual(list2))
        {
            return SublistType.Equal;
        }

        if (IsContiguousSubsequence(list1, list2))
        {
            return SublistType.Sublist;
        }

        if (IsContiguousSubsequence(list2, list1))
        {
            return SublistType.Superlist;
        }

        return SublistType.Unequal;
    }

    private static bool IsContiguousSubsequence<T>(List<T> shorter, List<T> longer)
        where T : IComparable
    {
        if (shorter.Count == 0)
        {
            return true;
        }

        if (shorter.Count > longer.Count)
        {
            return false;
        }

        for (int i = 0; i <= longer.Count - shorter.Count; i++)
        {
            bool matches = true;
            for (int j = 0; j < shorter.Count; j++)
            {
                if (longer[i + j].CompareTo(shorter[j]) != 0)
                {
                    matches = false;
                    break;
                }
            }
            if (matches)
            {
                return true;
            }
        }

        return false;
    }
}