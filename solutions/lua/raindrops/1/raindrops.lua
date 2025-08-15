return function(n)
    local is_divisible_by_3 = n % 3 == 0
    local is_divisible_by_5 = n % 5 == 0
    local is_divisible_by_7 = n % 7 == 0
    
    local result = ""

    if is_divisible_by_3 then
        result = result .. "Pling"
    end
    if is_divisible_by_5 then
        result = result .. "Plang"
    end
    if is_divisible_by_7 then
        result = result .. "Plong"
    end

    if result == "" then
        return string.format(n)
    else
        return result
    end
end
