return function(n)
    local result = ""

    local Mappings = {
        [3] = "Pling",
        [5] = "Plang",
        [7] = "Plong"
    }

    for divisor, label in pairs(Mappings) do
    end

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
        return result .. n
    else
        return result
    end
end
