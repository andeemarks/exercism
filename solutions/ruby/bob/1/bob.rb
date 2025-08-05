class Bob
    def self.hey(remark)
        remark = remark.strip
        case
        when remark.end_with?("?") && remark.upcase == remark && remark =~ /[A-Za-z]/
            "Calm down, I know what I'm doing!"
        when remark.end_with?("?")
            "Sure."
        when remark.upcase == remark && remark =~ /[A-Za-z]/
            "Whoa, chill out!"
        when remark.length == 0
            "Fine. Be that way!"
        else
            "Whatever."
        end
    end
end