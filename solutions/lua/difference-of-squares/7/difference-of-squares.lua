local function iterator(n, accumulator)
    local sum = 0

    for i = 1,n do
        sum = accumulator(sum, i)
    end

    return sum
end

local function add_square(total, current) return total + (current * current) end
local function add(total, current) return total + current end

local function sum_of_squares(n) return iterator(n, add_square) end
local function square_of_sum(n) local sum = iterator(n, add) return sum * sum end

local function difference_of_squares(n) return square_of_sum(n) - sum_of_squares(n) end

return { square_of_sum = square_of_sum, sum_of_squares = sum_of_squares, difference_of_squares = difference_of_squares }
