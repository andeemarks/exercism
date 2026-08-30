local function aliquot_sum(n)
    sum = 0
    for i=1,n/2 do 
        if n % i == 0 then
            sum = sum + i
        end
    end

    return sum
end

local function classify(n)
    sum = aliquot_sum(n)
    if sum == n then
        return "perfect"
    elseif sum < n then
        return "deficient"
    else 
        return "abundant"
    end
end

return { aliquot_sum = aliquot_sum, classify = classify }
