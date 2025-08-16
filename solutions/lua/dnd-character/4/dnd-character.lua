local Character = {}
Character.__index = Character

local function ability()
    local rolls = { math.random(1, 6), math.random(1, 6), math.random(1, 6), math.random(1, 6) }
    table.sort(rolls)

    return rolls[4] + rolls[3] + rolls[2]
end

local function modifier(input)
    return math.floor((input - 10) / 2)
end


function Character:new(name)
    self.strength = ability()
    self.dexterity = ability()
    self.constitution = ability()
    self.intelligence = ability()
    self.wisdom = ability()
    self.charisma = ability()
    self.hitpoints = 10 + modifier(self.constitution)
    self.name = name

    setmetatable({}, self)
    self.__index = self

    return self
end

return { Character = Character, ability = ability, modifier = modifier }
