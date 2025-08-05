class Bob
    def self.hey(remark)
        remark = remark.strip
        case
        when remark.is_question? && remark.upcase == remark && remark =~ /[A-Za-z]/
            "Calm down, I know what I'm doing!"
        when remark.is_question?
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

class String
    def is_question?
        self.end_with?("?")
    end
end