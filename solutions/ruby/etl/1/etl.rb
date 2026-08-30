module ETL
    def self.transform(letter_pairs)
        new = {}
        letter_pairs.each do 
            | score, letters |
            letters.each do 
                | letter |
                new[letter.downcase] = score
            end
        end

        new
    end
end