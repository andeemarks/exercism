require "iterator"

module ScrabbleScore
  def self.score(word : String) : Int32
    score = 0
    word.downcase.each_char do |letter|
      score += score_for_letter(letter)
    end

    score
  end

  def self.score_for_letter(letter : Char) : Int32
    case letter
    when 'a', 't', 'o', 's', 'r', 'e', 'u', 'i', 'n', 'l'
      1
    when 'd', 'g'
      2
    when 'b', 'p', 'm', 'c'
      3
    when 'f', 'y', 'h', 'v', 'w'
      4
    when 'k'
      5
    when 'j', 'x'
      8
    when 'q', 'z'
      10
    else
      0
    end
  end
end
