class Bob
    def self.hey(remark)
        remark = remark.strip
        case
        when remark.is_question? && remark.is_shout?
            "Calm down, I know what I'm doing!"
        when remark.is_question?
            "Sure."
        when remark.is_shout?
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

    def is_shout?
        self.upcase == self && self =~ /[A-Za-z]/
    end
end