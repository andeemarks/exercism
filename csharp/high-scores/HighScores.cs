using System;
using System.Collections.Generic;
using System.Linq;

public class HighScores
{
    private List<int> scores;

    public HighScores(List<int> list)
    {
        scores = list;
    }

    public List<int> Scores() => scores;

    public int Latest() => scores[^1];

    public int PersonalBest() => PersonalTopN(1).First();

    public List<int> PersonalTopThree() => PersonalTopN(3);

    private List<int> PersonalTopN(int n)
    {
        return scores.OrderDescending().Take(n).ToList();
    }
}