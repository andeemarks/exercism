using System.Text;

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

        var allVerses = new StringBuilder();
        for (var i = verseNumber - 1; i >= 1; i--)
        {
            allVerses.Append(VERSES[i]);
            allVerses.Append("the ");
        }
        return "This is the " + allVerses.ToString() + "house that Jack built.";
    }

    public static string Recite(int startVerse, int endVerse)
    {
        var rhyme = new StringBuilder();
        for (var i = startVerse; i <= endVerse; i++)
        {
            rhyme.Append(Recite(i));
            rhyme.Append('\n');
        }
        return rhyme.ToString().Trim();
    }
}