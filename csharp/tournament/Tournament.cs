using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Linq;

public static class Tournament
{
    private const string ResultsHeader = "Team                           | MP |  W |  D |  L |  P\n";
    public static void Tally(Stream inStream, Stream outStream)
    {
        IDictionary<string, TeamResult> results = new Dictionary<string, TeamResult>();
        string tournamentResults = new StreamReader(inStream).ReadToEnd().Trim();

        foreach (string matchResult in tournamentResults.Split("\n", StringSplitOptions.RemoveEmptyEntries))
        {
            results = UpdateTeamResults(new ResultLine(matchResult), results);
        }

        outStream.Write(Encoding.UTF8.GetBytes(ShowResults(results)));
    }

    private static IDictionary<string, TeamResult> UpdateTeamResults(ResultLine resultLine, IDictionary<string, TeamResult> results)
    {
        switch (resultLine.Result)
        {
            case "draw":
                GetTeamResults(resultLine.Team1, results).RecordDraw();
                GetTeamResults(resultLine.Team2, results).RecordDraw();
                break;
            case "win":
                GetTeamResults(resultLine.Team1, results).RecordWin();
                GetTeamResults(resultLine.Team2, results).RecordLoss();
                break;
            case "loss":
                GetTeamResults(resultLine.Team1, results).RecordLoss();
                GetTeamResults(resultLine.Team2, results).RecordWin();
                break;
        }

        return results;
    }

    private static string ShowResults(IDictionary<string, TeamResult> results)
    {
        StringBuilder sb = new StringBuilder(ResultsHeader);

        var orderedResults = from result in results.Values
                             orderby result.Points descending, result.Name ascending
                             select result;

        foreach (var result in orderedResults)
        {
            sb.AppendLine(result.ToString());
        }

        return sb.ToString().Trim();
    }
    private static TeamResult GetTeamResults(string name, IDictionary<string, TeamResult> results)
    {
        if (results.TryGetValue(name, out var foundTeamResult))
        {
            return foundTeamResult;
        }

        var newTeam = new TeamResult(name);
        results.Add(name, newTeam);

        return newTeam;
    }
}

internal class ResultLine
{
    public string Result { get; }
    public string Team1 { get; }
    public string Team2 { get; }

    public ResultLine(string rawLine)
    {
        string[] resultFields = rawLine.Split(";");
        Result = resultFields[2];
        Team1 = resultFields[0];
        Team2 = resultFields[1];
    }
}
internal class TeamResult
{
    private int MatchesPlayed;
    private int Wins;
    private int Draws;
    private int Losses;
    public int Points { get; private set; }
    public string Name { get; }

    public TeamResult(string name) => Name = name;

    public void RecordWin()
    {
        MatchesPlayed++; Wins++; Points += 3;
    }
    public void RecordLoss()
    {
        MatchesPlayed++; Losses++; Points += 0;
    }
    public void RecordDraw()
    {
        MatchesPlayed++; Draws++; Points += 1;
    }

    public override string ToString() => $"{rightPadToWidth(Name, 30)} | {format(MatchesPlayed)} | {format(Wins)} | {format(Draws)} | {format(Losses)} | {format(Points)}";

    private string format(int value) => leftPadToWidth(value.ToString(), 2);

    private string leftPadToWidth(String value, int width) => new string(' ', width - value.Length) + value;

    private string rightPadToWidth(string value, int width) => value + new string(' ', width - value.Length);
}