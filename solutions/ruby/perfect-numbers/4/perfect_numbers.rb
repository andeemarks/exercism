class PerfectNumber
    def self.classify(n)
        raise RuntimeError if n <= 0

        case factors_of(n).sum <=> n
        when 0
            "perfect"
        when -1
            "deficient"
        when 1
            "abundant"
        end
    end

    private
    def self.factors_of(n)
        (1..n / 2).filter { | i | n % i == 0 }
    end
end