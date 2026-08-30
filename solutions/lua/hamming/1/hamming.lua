local Hamming = {}

function Hamming.compute(a, b)
    local distance = 0

    if #a ~= #b then
        error("strands must be of equal length")
    end
    
    for i = 1, #a do 
        local char_a = a:sub(i, i)
        local char_b = b:sub(i, i)

        if (char_a ~= char_b) then
            distance = distance + 1
        end
    end

    return distance
end

return Hamming
