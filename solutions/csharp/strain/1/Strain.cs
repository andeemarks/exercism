public static class Strain
{
    public static IEnumerable<T> Keep<T>(this IEnumerable<T> collection, Func<T, bool> predicate)
    {
        return Evaluate(collection, predicate, true);
    }

    private static IEnumerable<T> Evaluate<T>(IEnumerable<T> collection, Func<T, bool> predicate, bool condition)
    {
        var results = new List<T>();

        foreach (var item in collection)
        {
            if (predicate(item) == condition)
            {
                results.Add(item);
            }
        }

        return results;
    }

    public static IEnumerable<T> Discard<T>(this IEnumerable<T> collection, Func<T, bool> predicate)
    {
        return Evaluate(collection, predicate, false);
    }
}