public static class Grep
{
    private record FileLine(string file, string text, int number);

    public static string Match(string pattern, string flags, string[] files)
    {
        var fileLines = IngestFiles(files);
        var matches = FindMatchesInFile(pattern, flags, fileLines);

        return string.Join("\n", matches).Trim();
    }

    private static List<string> FindMatchesInFile(string pattern, string flags, Dictionary<string, FileLine[]> fileLines)
    {
        var isMultipleFiles = fileLines.Keys.Count > 1;
        var matches = new List<string>();
        foreach (var lines in fileLines.Values)
        {
            foreach (var line in lines)
            {
                if (IsLineMatchingPattern(pattern, flags, line))
                {
                    AddMatchingLine(flags, isMultipleFiles, matches, line);
                }
            }
        }

        return matches;
    }

    private static void AddMatchingLine(string flags, bool isMultipleFiles, List<string> matches, FileLine line)
    {
        var matchedLine = line.text;
        var linePrefix = "";
        if (isMultipleFiles)
        {
            linePrefix = $"{line.file}:";
        }
        if (flags.IsShowLineNumber() && !flags.IsShowNamesOnly())
        {
            linePrefix += $"{line.number}:";
        }

        if (flags.IsShowNamesOnly())
        {
            if (!isMultipleFiles)
            {
                matchedLine = line.file;
            }
            else
            {
                linePrefix = $"{line.file}";
                matchedLine = "";
            }
        }

        if (linePrefix.Length > 0)
        {
            var item = $"{linePrefix}{matchedLine}";
            if (!matches.Contains(item))
            {
                matches.Add(item);
            }
        }
        else
        {
            matches.Add(matchedLine);
        }
    }

    private static bool IsLineMatchingPattern(string pattern, string flags, FileLine fileLine)
    {
        var searchLine = fileLine.text;
        var searchPattern = pattern;
        if (flags.IsCaseInsensitive())
        {
            searchLine = fileLine.text.ToLower();
            searchPattern = pattern.ToLower();
        }

        var partialMatch = !flags.IsMatchWholeLine() && searchLine.Contains(searchPattern);
        var fullMatch = flags.IsMatchWholeLine() && searchLine.Equals(searchPattern);
        var matchFound = partialMatch || fullMatch;

        if (flags.IsInverted())
        {
            matchFound = !matchFound;
        }

        return matchFound;
    }

    private static Dictionary<string, FileLine[]> IngestFiles(string[] files)
    {
        Directory.SetCurrentDirectory(Path.GetTempPath());
        var fileLines = new Dictionary<string, FileLine[]>();
        foreach (var fileName in files)
        {
            var contents = File.ReadAllText(fileName);
            var lines = contents.Split("\n");
            var fLines = new List<FileLine>();
            var lineNumber = 1;
            foreach (var line in lines)
            {
                if (line.Length > 0)
                {
                    fLines.Add(new FileLine(fileName, line, lineNumber));
                    lineNumber++;
                }
            }
            fileLines.Add(fileName, [.. fLines]);
        }

        return fileLines;
    }
}


public static class Flag
{
    public static bool IsInverted(this string flagSpec) => flagSpec.Contains("-v");
    public static bool IsShowLineNumber(this string flagSpec) => flagSpec.Contains("-n");
    public static bool IsShowNamesOnly(this string flagSpec) => flagSpec.Contains("-l");
    public static bool IsCaseInsensitive(this string flagSpec) => flagSpec.Contains("-i");
    public static bool IsMatchWholeLine(this string flagSpec) => flagSpec.Contains("-x");
}
