using System;

abstract class Character
{
    private string characterType;

    protected Character(string characterType)
    {
        this.characterType = characterType;
    }

    public abstract int DamagePoints(Character target);

    public virtual bool Vulnerable()
    {
        throw new NotImplementedException("Please implement the Character.Vulnerable() method");
    }

    public override string ToString()
    {
        return $"Character is a {this.characterType}";
    }
}

class Warrior : Character
{
    public Warrior() : base("Warrior")
    {
    }

    public override int DamagePoints(Character target)
    {
        if (target.Vulnerable())
        {
            return 10;
        }
        else
        {
            return 6;
        }
    }

    public override bool Vulnerable() => false;

}

class Wizard : Character
{
    private bool vulnerable = true;

    public Wizard() : base("Wizard")
    {
    }

    public override int DamagePoints(Character target)
    {
        if (Vulnerable())
        {
            return 3;
        }
        else
        {
            return 12;
        }
    }

    public void PrepareSpell()
    {
        this.vulnerable = false;
    }

    public override bool Vulnerable() => this.vulnerable;

}
