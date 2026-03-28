class TwelveDays
    def self.song
         (1..12).map{ |n| verse(n) }.join("\n")
    end

    def self.verse(n)
        verse_components = @@DAYS[n-1]
        gift_list = self.build_gift_list(verse_components, n)
        "On the #{verse_components[:ordinal]} day of Christmas my true love gave to me: #{gift_list}.\n"
    end

    def self.gifts_upto(n)
        @@DAYS.take(n+1).flat_map{|g| g[:gift]}.reverse
    end

    def self.build_gift_list(verse_components, verse_number)
        *gifts, terminal = gifts_upto(verse_number-1)

        return terminal if gifts.empty?

        "#{gifts.join(', ')}, and #{terminal}"
    end

    @@DAYS = [
        {:ordinal => "first", :gift => "a Partridge in a Pear Tree"},
        {:ordinal => "second", :gift => "two Turtle Doves"},
        {:ordinal => "third", :gift => "three French Hens"},
        {:ordinal => "fourth", :gift => "four Calling Birds"},
        {:ordinal => "fifth", :gift => "five Gold Rings"},
        {:ordinal => "sixth", :gift => "six Geese-a-Laying"},
        {:ordinal => "seventh", :gift => "seven Swans-a-Swimming"},
        {:ordinal => "eighth", :gift => "eight Maids-a-Milking"},
        {:ordinal => "ninth", :gift => "nine Ladies Dancing"},
        {:ordinal => "tenth", :gift => "ten Lords-a-Leaping"},
        {:ordinal => "eleventh", :gift => "eleven Pipers Piping"},
        {:ordinal => "twelfth", :gift => "twelve Drummers Drumming"}
    ]
end