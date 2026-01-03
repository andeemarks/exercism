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
        switch(true)
        {
            case true when list1.SequenceEqual(list2):
                return SublistType.Equal;
            case true when IsContiguousSubsequence(list1, list2):
                return SublistType.Sublist;
            case true when IsContiguousSubsequence(list2, list1):
                return SublistType.Superlist;
            default:
                return SublistType.Unequal;
        }
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