module Pangram
  ( isPangram
  ) where

import           Data.Char
import           Data.List.Split
import qualified Data.Set        as Set
import           Debug.Trace

isPangram :: String -> Bool
isPangram text
  | trace (show text) False = undefined
isPangram text = do
  let textLower = lowercase text
      letters = splitOn "" textLower
   in Set.size uniqueLetters letters == 26

lowercase :: String -> String
lowercase = map toLower

uniqueLetters :: String -> Set.Set
uniqueLetters letter = Set.fromList letters
