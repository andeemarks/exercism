using System;

static class GameMaster
{
    public static string Describe(Character character)
    {
        return $"You're a level {character.Level} {character.Class} with {character.HitPoints} hit points.";
    }

    public static string Describe(Destination destination)
    {
        return $"You've arrived at {destination.Name}, which has {destination.Inhabitants} inhabitants.";
    }

    public static string Describe(TravelMethod travelMethod)
    {
        if (travelMethod is TravelMethod.Walking)
        {
            return $"You're traveling to your destination by walking.";
        }
        else if (travelMethod is TravelMethod.Horseback)
        {
            return $"You're traveling to your destination on horseback.";
        }

        return "";
    }

    public static string Describe(Character character, Destination destination, TravelMethod travelMethod)
    {
        return $"{GameMaster.Describe(character)} {GameMaster.Describe(travelMethod)} {GameMaster.Describe(destination)}";
    }

    public static string Describe(Character character, Destination destination)
    {
        return $"{GameMaster.Describe(character, destination, TravelMethod.Walking)}";
    }
}

class Character
{
    public string Class { get; set; }
    public int Level { get; set; }
    public int HitPoints { get; set; }
}

class Destination
{
    public string Name { get; set; }
    public int Inhabitants { get; set; }
}

enum TravelMethod
{
    Walking,
    Horseback
}
