class SumOfMultiples
    def initialize(*base_values)
        @values = base_values
    end

    def to(level)
        multiples = Set.new
        @values.each do
            | value |
            multiples.merge(find_multiples_for(value, level)) if value > 0
        end

        multiples.sum
    end

    private
    def find_multiples_for(start, limit)
        multiples = []
        multiple = start
        i = 2
        while multiple < limit
            multiples << multiple
            multiple = start * i
            i += 1
        end

        # puts "Multiples for #{start} to #{limit} = #{multiples}"
        multiples

    end
end