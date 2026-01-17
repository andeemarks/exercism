public class DndCharacter
{
    public int Strength { get; } = Ability();
    public int Dexterity { get; } = Ability();
    public int Constitution { get; } = Ability();
    public int Intelligence { get; } = Ability();
    public int Wisdom { get; } = Ability();
    public int Charisma { get; } = Ability();
    public int Hitpoints { get; set;}

    public static int Modifier(int score) => (int)Math.Floor((score - 10) / 2.0);

    public static int Ability() 
    {
        var allRolls = new List<int> { RollD6(), RollD6(), RollD6(), RollD6() };

        return allRolls.Sum() - allRolls.Min();
    }

    private static int RollD6() {
        var random = new Random();
        return random.Next(1, 7);
    }

    public static DndCharacter Generate() 
    {
        var character = new DndCharacter();
        character.Hitpoints = 10 + Modifier(character.Constitution);

        return character;
    }
}
