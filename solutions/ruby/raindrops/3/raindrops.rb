class Raindrops
  def self.convert(n)

    sound = ""
    if n % 3 == 0
      sound << "Pling"
    end

    if n % 5 == 0
      sound << "Plang"
    end

    if n % 7 == 0
      sound << "Plong"
    end

    return n.to_s if sound.empty? 
    
    sound
  end
end