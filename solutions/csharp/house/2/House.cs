using System.Text;

public static class House
{
    public static string Recite(int verseNumber)
    {
        var verses = new List<string>
        {
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
        };

        // if (verseNumber > 1)
        // {
            var allVerses = new StringBuilder();
            for (var i = verseNumber - 1; i >= 1; i--)
            {
                allVerses.Append(verses[i]);
                allVerses.Append("the ");
            }
            return "This is the " + allVerses.ToString() + "house that Jack built.";
        // }
        // else
        // {
        //     return "This is " + verses[verseNumber - 1] + " that Jack built.";
        // }
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