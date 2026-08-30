return function(n)
    local result = ""

    if n % 3 == 0 then
        result = result .. "Pling"
    end
    if n % 5 == 0 then
        result = result .. "Plang"
    end
    if n % 7 == 0 then
        result = result .. "Plong"
    end

    if result == "" then
        return string.format(n)
    else
        return result
    end
end
