using System;
using System.Text.RegularExpressions;

static class LogLine
{
    static string[] logLevels = { "ERROR", "INFO", "WARNING" };

    public static string Message(string logLine)
    {
        foreach (string logLevel in logLevels)
        {
            if (isAtLogLevel(logLine, logLevel))
            {
                return extractLogFromLine(logLine, formatLogLevel(logLevel));
            }
        }

        return logLine;
    }

    private static bool isAtLogLevel(string logLine, string logLevel)
    {
        return logLine.IndexOf(formatLogLevel(logLevel)) == 0;
    }

    private static string extractLogFromLine(string logLine, string level)
    {
        return logLine.Substring(level.Length).Trim();
    }

    public static string LogLevel(string logLine)
    {
        foreach (string logLevel in logLevels)
        {
            if (isAtLogLevel(logLine, logLevel))
            {
                return logLevel.ToLower();
            }
        }

        return logLine;
    }

    public static string Reformat(string logLine)
    {
        return $"{Message(logLine)} ({LogLevel(logLine)})";
    }

    private static string formatLogLevel(string logLevel)
    {
        return "[" + logLevel + "]:";
    }
}
