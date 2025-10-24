using System.Text;

using Microsoft.Testing.Platform.Extensions.Messages;

public static class House
{
    private static readonly List<string> VERSES =
    [
        "the house",
        "malt that lay in ",
        "rat that ate ",
        "cat that killed ",
        "dog that worried ",
        "cow with the crumpled horn that tossed ",
        "maiden all forlorn that milked ",
        "man all tattered and torn that kissed ",
        "priest all shaven and shorn that married ",
        "rooster that crowed in the morn that woke ",
        "farmer sowing his corn that kept ",
        "horse and the hound and the horn that belonged to ",
    ];

    public static string Recite(int verseNumber)
    {
        var allVerses = Enumerable.Reverse(Enumerable.Range(1, verseNumber - 1)).Select(i => VERSES[i] + "the ");

        return "This is the " + String.Join("", allVerses) + "house that Jack built.";
    }

    public static string Recite(int startVerse, int endVerse)
    {
        var count = endVerse - startVerse + 1;
        var lines = Enumerable.Range(startVerse, count).Select(i => Recite(i));

        return String.Join("\n", lines.ToArray());
    }
}