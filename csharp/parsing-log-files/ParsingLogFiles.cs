using System.Text.RegularExpressions;
using System.Text;

public class LogParser
{
    public bool IsValidLine(string text) => Regex.IsMatch(text, @"^\[(TRC|DBG|INF|WRN|ERR|FTL)\].*$");

    public string[] SplitLogLine(string text) => Regex.Split(text, @"<[\^\*\=\-]+>");

    public int CountQuotedPasswords(string lines) => Regex.Matches(lines, @"^.*"".*password.*"".*$", RegexOptions.Multiline | RegexOptions.IgnoreCase).Count;

    public string RemoveEndOfLineText(string line) => string.Join("", new Regex(@"end\-of\-line\d+").Split(line));

    public string[] ListLinesWithPasswords(string[] lines)
    {
        var result = new StringBuilder();
        foreach (var line in lines)
        {
            var passwordsInLine = Regex.Match(line, @".*(password\S+).*$", RegexOptions.IgnoreCase).Groups;
            result = result.AppendLine(formatResultLine(passwordsInLine, line));
        };

        return result.ToString().Trim().Split("\n");
    }

    private string formatResultLine(GroupCollection passwordsInLine, string line)
    {
        return passwordsInLine[1].Success ? $"{passwordsInLine[1].Value}: {line}" : $"--------: {line}";
    }
}
