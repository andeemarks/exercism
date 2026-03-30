class Isogram
  def self.isogram?(input)
    input_chars = input.downcase.gsub(/[^a-z]/, '').chars
    input_chars.uniq.length == input_chars.length
  end
end