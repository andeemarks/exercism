local Character = {}
Character.__index = Character

function Character:new(name)
    -- local instance = { 
    --     name = name,
    --     strength = 12,
    --     dexterity = 12,
    --     constitution = 12,
    --     intelligence = 12,
    --     wisdom = 12,
    --     charisma = 12,
    --     hitpoints = 10 + 2 }
    self.strength = 12
    self.dexterity = 12
    self.constitution = 12
    self.intelligence = 12
    self.wisdom = 12
    self.charisma = 12
    self.hitpoints = 10 + 1
    self.name = name
    -- setmetatable(instance, self)

    return self
end

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

return { Character = Character, ability = ability, modifier = modifier }
