from random import randint

class Character:
    def __init__(self):
        self.d6 = Die(6)
        self.strength = self.highest_die_rolls()
        self.dexterity = self.highest_die_rolls()
        self.constitution = self.highest_die_rolls()
        self.intelligence = self.highest_die_rolls()
        self.charisma = self.highest_die_rolls()
        self.wisdom = self.highest_die_rolls()
        self.hitpoints = 10 + modifier(self.constitution)

    def ability(self):
        return self.highest_die_rolls()

    def highest_die_rolls(self):
        return sum(self.d6.roll_times(4)[:3])
    
def modifier(constitution):
    return (constitution - 10) // 2

class Die:
    def __init__(self, sides):
        self.sides = sides

    def roll(self):
        return randint(1, self.sides)

    def roll_times(self, roll_count):
        return [self.roll() for i in range(roll_count)]
