class Translation
  def self.of_rna(strand)
    translated = []
    for c in strand.scan(/.{1,3}/) do
      translation = self.map_codon(c)

      break if translation == :stop_codon

      translated << translation
    end

    translated.flatten()
  end
  
  def self.map_codon(codon)
    mappings = {'AUG' => 'Methionine', 
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
              
    raise InvalidCodonError if !mappings.has_key?(codon)

    mappings.fetch(codon)
  end


end

class InvalidCodonError < StandardError
  
end