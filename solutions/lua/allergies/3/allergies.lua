local function list(score)
    allergies = {}
    if score > 256 then
        score = score - 256
    end

    score = check(allergies, score, 128, 'cats')
    score = check(allergies, score, 64, 'pollen')
    score = check(allergies, score, 32, 'chocolate')
    score = check(allergies, score, 16, 'tomatoes')
    score = check(allergies, score, 8, 'strawberries')
    score = check(allergies, score, 4, 'shellfish')
    score = check(allergies, score, 2, 'peanuts')
    score = check(allergies, score, 1, 'eggs')

    return reverseTable(allergies)
end

function check(allergies, score, allergyScore, allergyName)
    if score - allergyScore >= 0 then
        table.insert(allergies, allergyName)
        score = score - allergyScore
    end

    return score
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
