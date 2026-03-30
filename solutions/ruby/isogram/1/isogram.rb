class Isogram
  def self.isogram?(input)
    input.downcase.gsub(/[^a-z]/, '').chars.uniq.length == input.downcase.gsub(/[^a-z]/, '').length
  end
end