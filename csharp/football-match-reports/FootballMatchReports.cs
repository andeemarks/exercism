using System;

public static class PlayAnalyzer
{
    public static string AnalyzeOnField(int shirtNum)
    {
        switch (shirtNum)
        {
            case 1: return "goalie";
            case 8: return "midfielder";
            case 10: return "striker";
            case 11: return "right wing";
            default: throw new ArgumentOutOfRangeException();
        }
    }

    public static string AnalyzeOffField(object report)
    {
        switch (report)
        {
            case int: return $"There are {report} supporters at the match.";
            case float: throw new ArgumentException();
            case string: return $"{report.ToString()}";
            case Injury injury: return $"Oh no! {injury.GetDescription()} Medics are on the field.";
            case Foul: return "The referee deemed a foul.";
            case Incident: return "An incident happened.";
            case Manager manager: return $"{manager.Name}{(manager.Club == null ? "" : " (" + manager.Club + ")")}";
            default: throw new ArgumentOutOfRangeException();
        }
    }
}
