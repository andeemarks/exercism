class TwelveDays
    def self.song
<<SONG
#{verse(0)}

#{verse(1)}

#{verse(2)}

#{verse(3)}

#{verse(4)}

#{verse(5)}

#{verse(6)}

#{verse(7)}

#{verse(8)}

#{verse(9)}

#{verse(10)}

#{verse(11)}
SONG
    end

    def self.verse(n)
        verse_components = @@components[n]
        gift_list = self.build_gift_list(verse_components, n)
        "On the #{verse_components[:ordinal]} day of Christmas my true love gave to me: #{gift_list}."
    end

    def self.build_gift_list(verse_components, verse_number)
        gift_list = verse_components[:gift]
        if verse_number > 0 then
            (verse_number-1).step(0, -1) do |i|
                if i == 0 then
                    gift_list = gift_list + ", and " + @@components[i][:gift]
                else
                    gift_list = gift_list + ", " + @@components[i][:gift]
                end
            end
        end

        gift_list
    end

    @@components = [
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