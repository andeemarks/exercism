using System;
using System.Collections.Generic;

public enum Allergen
{
    Eggs = 1,
    Peanuts = 2,
    Shellfish = 4,
    Strawberries = 8,
    Tomatoes = 16,
    Chocolate = 32,
    Pollen = 64,
    Cats = 128
}

public class Allergies
{
    public Allergies(int mask)
    {
        this.mask = (Allergen)mask;
    }

    public Allergen mask { get; }

    public bool IsAllergicTo(Allergen allergen)
    {
        return (mask & allergen) == allergen;
    }

    public Allergen[] List()
    {
        var results = new List<Allergen>();

        foreach (Allergen allergen in Enum.GetValues(typeof(Allergen)))
        {
            results = AddIfAllergicTo(results, allergen);
        }

        return results.ToArray();
    }

    private List<Allergen> AddIfAllergicTo(List<Allergen> results, Allergen allergen)
    {
        if (IsAllergicTo(allergen))
        {
            results.Add(allergen);
        }

        return results;
    }
}