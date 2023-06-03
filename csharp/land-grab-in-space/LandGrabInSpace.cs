using System;
using System.Collections.Generic;

public struct Coord
{
    public Coord(ushort x, ushort y)
    {
        X = x;
        Y = y;
    }

    public ushort X { get; }
    public ushort Y { get; }

    public double DistanceTo(Coord other)
    {
        return Math.Sqrt(Math.Pow(Math.Abs(X - other.X), 2) + Math.Pow(Math.Abs(Y - other.Y), 2));
    }
}

public struct Plot : IComparable<Plot>
{
    public Plot(Coord top, Coord left, Coord bottom, Coord right)
    {
        Top = top;
        Left = left;
        Bottom = bottom;
        Right = right;
        LongestSide = FindLongestSide();
    }

    private double FindLongestSide()
    {
        var sideLengths = new List<double>() {
            Top.DistanceTo(Left),
            Left.DistanceTo(Bottom),
            Bottom.DistanceTo(Right),
            Right.DistanceTo(Top)
        };

        sideLengths.Sort();

        return sideLengths[0];
    }

    public Coord Top { get; }
    public Coord Left { get; }
    public Coord Bottom { get; }
    public Coord Right { get; }

    public double LongestSide { get; }

    public int CompareTo(Plot other)
    {
        return other.LongestSide.CompareTo(LongestSide);
    }
}


public class ClaimsHandler
{
    public List<Plot> StakedClaims = new List<Plot>();

    public void StakeClaim(Plot plot)
    {
        StakedClaims.Add(plot);
    }

    public bool IsClaimStaked(Plot plot)
    {
        return StakedClaims.Contains(plot);
    }

    public bool IsLastClaim(Plot plot)
    {
        return StakedClaims[StakedClaims.Count - 1].Equals(plot);
    }

    public Plot GetClaimWithLongestSide()
    {
        StakedClaims.Sort();
        return StakedClaims[0];
    }
}
