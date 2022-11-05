using System;
using System.Collections.Generic;

public static class AccumulateExtensions
{
    public static IEnumerable<U> Accumulate<T, U>(this IEnumerable<T> collection, Func<T, U> func)
    {
        var items = collection.GetEnumerator();
        IList<U> result = new List<U>();
        while (items.MoveNext())
        {
            yield return func(items.Current);
        }
    }
}