local function list(score)
    allergies = {}
    if score > 256 then
        score = score - 256
    end

    local allergyScores = {[128] = 'cats', [64] = 'pollen', [32] = 'chocolate', [16] = 'tomatoes', [8] = 'strawberries', [4] = 'shellfish', [2] = 'peanuts', [1] = 'eggs'}
    score = _check(allergies, score, 128, 'cats')
    score = _check(allergies, score, 64, 'pollen')
    score = _check(allergies, score, 32, 'chocolate')
    score = _check(allergies, score, 16, 'tomatoes')
    score = _check(allergies, score, 8, 'strawberries')
    score = _check(allergies, score, 4, 'shellfish')
    score = _check(allergies, score, 2, 'peanuts')
    score = _check(allergies, score, 1, 'eggs')

    return _reverseTable(allergies)
end

function _check(allergies, score, allergyScore, allergyName)
    if score - allergyScore >= 0 then
        table.insert(allergies, allergyName)
        score = score - allergyScore
    end

    return score
end

function _reverseTable(t)
    local len = #t
    for i = 1, math.floor(len / 2) do
        t[i], t[len - i + 1] = t[len - i + 1], t[i]
    end

    return t
end

local function _contains(t, v)
    for index, value in ipairs(t) do
        if value == v then
            return true
        end
    end
    return false
end

local function allergic_to(score, which)
    allergies = list(score)

    return _contains(allergies, which)
end

return { list = list, allergic_to = allergic_to }
