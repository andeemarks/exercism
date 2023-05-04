module LeapYear
  ( isLeapYear
  ) where

isLeapYear :: Integer -> Bool
isLeapYear year
  | yearDivisibleBy 400 = True
  | yearDivisibleBy 100 = False
  | yearDivisibleBy 4 = True
  | otherwise = False
  where
    yearDivisibleBy x = mod year x == 0
