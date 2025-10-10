public static class Strain
{
    public static IEnumerable<T> Keep<T>(this IEnumerable<T> collection, Func<T, bool> predicate) => Evaluate(collection, predicate, true);
    public static IEnumerable<T> Discard<T>(this IEnumerable<T> collection, Func<T, bool> predicate) => Evaluate(collection, predicate, false);

    private static IEnumerable<T> Evaluate<T>(IEnumerable<T> collection, Func<T, bool> predicate, bool condition)
    {
        return from item in collection where predicate(item) == condition select item;
    }

}