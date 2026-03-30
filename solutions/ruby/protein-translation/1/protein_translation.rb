class Translation
  def self.of_rna(strand)
    proteins = strand.scan(/.{1,3}/)
    translated = []
    for p in proteins do
      translation = self.map_protein(p)
      if translation == :stop_codon then
        break
      end
      translated << translation
    end

    stop_codon_pos = translated.index(:stop_codon)

    translated = translated.take(stop_codon_pos) if stop_codon_pos
    translated.flatten()
  end
  
  def self.map_protein(protein)
    raise InvalidCodonError if !@@MAPPINGS.has_key?(protein)

    @@MAPPINGS.fetch(protein, [])
  end

  @@MAPPINGS = {'AUG' => 'Methionine', 
                'UUU' => 'Phenylalanine',
                'UUC' => 'Phenylalanine',
                'UUA' => 'Leucine',
                'UUG' => 'Leucine',
                'UCU' => 'Serine',
                'UCC' => 'Serine',
                'UCA' => 'Serine',
                'UCG' => 'Serine',
                'UAU' => 'Tyrosine',
                'UAC' => 'Tyrosine',
                'UGU' => 'Cysteine',
                'UGC' => 'Cysteine',
                'UGG' => 'Tryptophan',
                'UGA' => :stop_codon,
                'UAG' => :stop_codon,
                'UAA' => :stop_codon,
              }
end

class InvalidCodonError < StandardError
  
end