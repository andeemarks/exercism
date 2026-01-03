using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class SimpleLinkedList<T> : IEnumerable<T>
{
    private readonly List<T> items = [];
    public int Count { get; private set; }

    public SimpleLinkedList()
    {

    }

    public SimpleLinkedList(T value) => Push(value);
    public SimpleLinkedList(IEnumerable<T> values) => values.ToList().ForEach(Push);

    public void Push(T value)
    {
        if (items.Count < Count + 1)
        {
            items.Add(value);
        }

        Count++;
    }

    public T Pop()
    {
        T item = items[^1];
        items.RemoveAt(items.Count - 1);
        Count--;

        return item;
    }

    public IEnumerator<T> GetEnumerator() => items.Reverse<T>().GetEnumerator();
    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();

}
