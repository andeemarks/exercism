using Xunit.Sdk;

public static class Flag
{
    public static bool IsInverted(this string flagSpec) => flagSpec.Contains("-v");
    public static bool IsShowLineNumber(this string flagSpec) => flagSpec.Contains("-n");
    public static bool IsShowNamesOnly(this string flagSpec) => flagSpec.Contains("-l");
    public static bool IsCaseInsensitive(this string flagSpec) => flagSpec.Contains("-i");
    public static bool IsMatchWholeLine(this string flagSpec) => flagSpec.Contains("-x");
}

public static class Grep
{
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
                var isMatchFound = CheckLineForPattern(pattern, flags, line);

                if (isMatchFound)
                {
                    AddMatchingLine(flags, isMultipleFiles, matches, line);
                }
            }
        }

        return matches;
    }

    private static void AddMatchingLine(string flags, bool isMultipleFiles, List<string> matches, FileLine line)
    {
        var matchLine = line.line;
        var linePrefix = "";
        if (isMultipleFiles)
        {
            linePrefix = $"{line.fileName}:";
        }
        if (flags.IsShowLineNumber() && !flags.IsShowNamesOnly())
        {
            linePrefix += $"{line.lineNumber}:";
        }

        if (flags.IsShowNamesOnly())
        {
            if (!isMultipleFiles)
            {
                matchLine = line.fileName;
            }
            else
            {
                linePrefix = $"{line.fileName}";
                matchLine = "";
            }
        }

        if (linePrefix.Length > 0)
        {
            var item = $"{linePrefix}{matchLine}";
            if (!matches.Contains(item))
            {
                matches.Add(item);
            }
        }
        else
        {
            matches.Add(matchLine);
        }
    }

    private static bool CheckLineForPattern(string pattern, string flags, FileLine fileLine)
    {
        var searchLine = fileLine.line;
        var searchPattern = pattern;
        if (flags.IsCaseInsensitive())
        {
            searchLine = fileLine.line.ToLower();
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

public readonly struct FileLine(string fileName, string line, int lineNumber)
{
    public string fileName { get; } = fileName;
    public string line { get; } = line;
    public int lineNumber { get; } = lineNumber;
}