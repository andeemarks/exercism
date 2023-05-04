return function(s)
    local unique_letters = {}
    local sentence = s:gsub('%W','')

    sentence:gsub(".", function(letter)
        unique_letters[letter:upper()] = true
    end)

    local unique_letter_count = 0
    for k, v in pairs(unique_letters) do
        unique_letter_count = unique_letter_count + 1
    end

    return unique_letter_count == sentence:len()

end
