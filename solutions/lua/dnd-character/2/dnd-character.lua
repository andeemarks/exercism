local Character = {}
Character.__index = Character

local function ability()
    local rolls = { math.random(1, 6), math.random(1, 6), math.random(1, 6), math.random(1, 6) }
    table.sort(rolls)

    local highest_rolls = {table.unpack(rolls, 2, 4)}

    local score = 0
    for roll in pairs(highest_rolls) do
        score = score + roll
    end

    return score
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

    return self
end

return { Character = Character, ability = ability, modifier = modifier }
