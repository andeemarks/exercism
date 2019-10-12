class RomanNumeral {
    companion object {
        fun value(number: Int): String {
            val digits = number.toString().toCharArray()
            return digits.mapIndexed { i: Int, digit: Char ->
                findNumeral(digit, findDigitPlace(i, digits))
            }.joinToString("")
        }

        private fun findNumeral(digit: Char, place: Place): String {
            return when (digit - '0') {
                1, 2, 3 -> place.base.repeat((digit - '0'))
                4 -> place.base + place.median
                5 -> place.median
                6, 7, 8 -> place.median + place.base.repeat((digit - '5'))
                9 -> place.base + place.parent
                else -> ""
            }
        }

        private fun findDigitPlace(i: Int, digits: CharArray): Place {
            return when (i) {
                digits.size - 1 -> Place.ONES
                digits.size - 2 -> Place.TENS
                digits.size - 3 -> Place.HUNDREDS
                else -> Place.THOUSANDS
            }
        }
    }

    enum class Place(val base: String, val median: String, val parent: String) {
        ONES("I", "V", "X"),
        TENS("X", "L", "C"),
        HUNDREDS("C", "D", "M"),
        THOUSANDS("M", "M", "M")
    }
}
