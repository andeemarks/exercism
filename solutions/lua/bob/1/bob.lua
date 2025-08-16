local bob = {}

function bob.hey(say)
    local trimmed = say:gsub("%s+", "")
    local is_empty = #(trimmed) == 0
    local has_letters = #(say:gsub("%A", "")) > 0
    local is_shouted = say:upper() == say and has_letters
    local is_question = string.sub(trimmed, -1) == "?"
    if is_shouted and is_question then
        return "Calm down, I know what I'm doing!"
    elseif is_shouted then
        return "Whoa, chill out!"
    elseif is_question then
        return "Sure."
    elseif is_empty then
        return "Fine. Be that way!"
    else
        return "Whatever."
    end
end

return bob
