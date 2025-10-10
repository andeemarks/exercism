public static class Strain
{
    public static IEnumerable<T> Keep<T>(this IEnumerable<T> collection, Func<T, bool> predicate) => Evaluate(collection, predicate, true);
    public static IEnumerable<T> Discard<T>(this IEnumerable<T> collection, Func<T, bool> predicate) => Evaluate(collection, predicate, false);

    private static List<T> Evaluate<T>(IEnumerable<T> collection, Func<T, bool> predicate, bool condition)
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

}