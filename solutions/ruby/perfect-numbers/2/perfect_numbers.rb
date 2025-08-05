class PerfectNumber
    def self.classify(n)
        raise RuntimeError if n <= 0

        sum_of_factors = factors_of(n).sum

        case sum_of_factors <=> n
        when 0
            "perfect"
        when -1
            "deficient"
        else
            "abundant"
        end
    end

    private
    def self.factors_of(n)
        (1..n / 2).filter { | i | n % i == 0 }
    end
end