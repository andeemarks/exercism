
class Luhn {
    companion object {
        private fun doubleDigit(digit: Int): Int {
            return if (digit * 2 > 9) {
                digit * 2 - 9
            } else {
                digit * 2
            }
        }

        private fun doubleEvery2ndDigit(digit: Int, position: Int): Int {
            return if (position.rem(2) == 0) {
                digit
            } else {
                doubleDigit(digit)
            }
        }

        fun isValid(number: String): Boolean {
            val numbersOnly = number.filter(Character::isDigit).map(Character::getNumericValue)
            val invalidChars = number.filter { c: Char -> !(c.isDigit() || c.isWhitespace())}
            val doubledNumbers = numbersOnly.reversed().mapIndexed { index, digit -> doubleEvery2ndDigit(digit, index) }
            val sumOfNumbers = doubledNumbers.reduce { sum, i -> sum + i }

            return numbersOnly.size > 1 && invalidChars.isEmpty() && sumOfNumbers.rem(10) == 0

        }
    }
}
