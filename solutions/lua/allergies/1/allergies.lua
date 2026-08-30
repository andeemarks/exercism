local function list(score)
    allergies = {}
    if score > 256 then
        score = score - 256
    end

    if score - 128 >= 0 then
        table.insert(allergies, 'cats')
        score = score - 128
    end
    if score - 64 >= 0 then
        table.insert(allergies, 'pollen')
        score = score - 64
    end
    if score - 32 >= 0 then
        table.insert(allergies, 'chocolate')
        score = score - 32
    end
    if score - 16 >= 0 then
        table.insert(allergies, 'tomatoes')
        score = score - 16
    end
    if score - 8 >= 0 then
        table.insert(allergies, 'strawberries')
        score = score - 8
    end
    if score - 4 >= 0 then
        table.insert(allergies, 'shellfish')
        score = score - 4
    end
    if score - 2 >= 0 then
        table.insert(allergies, 'peanuts')
        score = score - 2
    end
    if score - 1 >= 0 then
        table.insert(allergies, 'eggs')
        score = score - 1
    end

    return reverseTable(allergies)
end

function reverseTable(t)
    local len = #t
    for i = 1, math.floor(len / 2) do
        t[i], t[len - i + 1] = t[len - i + 1], t[i]
    end

    return t
end

local function contains(t, v)
    for index, value in ipairs(t) do
        if value == v then
            return true
        end
    end
    return false
end

local function allergic_to(score, which)
    allergies = list(score)

    return contains(allergies, which)
end

return { list = list, allergic_to = allergic_to }
