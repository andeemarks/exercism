class Scrabble
    def initialize(word)
        @word = word.downcase
    end

    def score()
        @word.chars.sum do
            | letter |
            case letter
            when 'z', 'q' then 10
            when 'x', 'j' then 8
            when 'k' then 5
            when 'f', 'y', 'h', 'v', 'w' then 4
            when 'p', 'b', 'm', 'c' then 3
            when 'd', 'g' then 2
            else 1
            end
        end
    end
end