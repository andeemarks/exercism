class Integer
  def to_roman
    numeral = self
    thousands = numeral.div(1000)    
    numeral -= thousands * 1000
    five_hundreds = numeral.div(500)    
    numeral -= five_hundreds * 500
    hundreds = numeral.div(100)    
    numeral -= hundreds * 100
    fifties = numeral.div(50)    
    numeral -= fifties * 50
    tens = numeral.div(10)    
    numeral -= tens * 10
    
    roman = ""
    roman << "M" * thousands
    if five_hundreds == 1 && hundreds == 4
      roman << "CM"
    else
      roman << "D" * five_hundreds
      if hundreds > 3 then
        roman << "CD"
      else
        roman << "C" * hundreds
      end
    end
    if fifties == 1 && tens == 4
      roman << "XC"
    else
      roman << "L" * fifties
      if tens > 3 then
        roman << "XL"
      else
        roman << "X" * tens
      end
    end
    digits = numeral

    roman << @@NUMERALS[digits - 1] if digits > 0

    roman
  end

  @@NUMERALS = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"]
end
