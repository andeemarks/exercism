module Complement
    def self.of_dna(sequence)
        sequence.tr('GCTA', 'CGAU')
    end
end