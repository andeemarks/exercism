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
        gift_list = verse_components[:gift]
        if n > 0 then
            (n-1).step(0, -1) do |i|
                if i == 0 then
                    gift_list = gift_list + ", and " + @@components[i][:gift]
                else
                    gift_list = gift_list + ", " + @@components[i][:gift]
                end
            end
        end
        "On the #{verse_components[:ordinal]} day of Christmas my true love gave to me: #{gift_list}."
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