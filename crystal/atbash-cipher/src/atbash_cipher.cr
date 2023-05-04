module AtbashCipher
  # Write your code for the 'Atbash Cipher' exercise in this file.
  @@alphabet : Array(Char) = ('a'..'z').to_a + ('0'..'9').to_a
  @@tebahpla : Array(Char) = ('a'..'z').to_a.reverse + ('0'..'9').to_a

  def self.encode(message : String) : String
    clean_letters = clean_message(message)
    counter = 0
    clean_letters.reduce("") { |encoded_message, letter|
      counter += 1
      encoded_letter = encode_letter(letter)
      if (counter % 5 == 0)
        encoded_message + encoded_letter + " "
      else
        encoded_message + encoded_letter
      end
    }.strip
  end

  def self.decode(message : String) : String
    clean_letters = clean_message(message)
    clean_letters.reduce("") { |encoded_message, letter|
      encoded_message + encode_letter(letter)
    }.strip
  end

  private def self.encode_letter(letter) : String
    @@tebahpla[@@alphabet.index(letter[0]) || 0].to_s
  end

  private def self.clean_message(message : String) : Array(String)
    message.downcase.gsub(/[^a-z0-9]/, "").split("")
  end
end
