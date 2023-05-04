letterscores = {}
letterscores['D'] = 2
letterscores['G'] = 2
letterscores['B'] = 3
letterscores['C'] = 3
letterscores['M'] = 3
letterscores['P'] = 3
letterscores['F'] = 4
letterscores['H'] = 4
letterscores['V'] = 4
letterscores['W'] = 4
letterscores['Y'] = 4
letterscores['K'] = 5
letterscores['J'] = 8
letterscores['X'] = 8
letterscores['Q'] = 10
letterscores['Z'] = 10

local function score(word)
    score = 0
    string.upper(word or ""):gsub(".", function(letter)
        score = score + (letterscores[letter] or 1)
    end)
    
    return score
end

return { score = score }
