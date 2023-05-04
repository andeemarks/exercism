local triangle = {}

function triangle.kind(a, b, c)
    assert(a > 0, "Input Error")
    assert(b > 0, "Input Error")
    assert(c > 0, "Input Error")

    local sides = {a, b, c}
    table.sort(sides)

    if (sides[3] > sides[2] + sides[1]) then
        error('Input Error')
    end

    if (a == b and b == c) then
        return 'equilateral'
    end
    if (sides[1] == sides[2] or sides[2] == sides[3]) then
        return 'isosceles'
    end

    return 'scalene'
end

return triangle
