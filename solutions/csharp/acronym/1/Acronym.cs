using System.Reflection.PortableExecutable;

public static class Acronym
{
    public static string Abbreviate(string phrase)
    {
        char[] boundaries = [' ', '-', '_'];
        string[] words = phrase.Split(boundaries, StringSplitOptions.RemoveEmptyEntries);

        return string.Join("", words.Select(word => word.ToUpper().First()));
    }
}