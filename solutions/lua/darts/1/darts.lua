local Darts = {}

function Darts.score(x, y)
    local distance = math.sqrt(x * x + y * y)

    if distance > 10 then
        return 0
    elseif distance <= 1 then
        return 10
    elseif distance <= 5 then
        return 5
    else
        return 1
    end
end

return Darts
