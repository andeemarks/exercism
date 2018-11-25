class IsbnVerifier {

    fun findMultiplierForChar(index: Int, char: Char): Int {
        if (char.equals('X', true)) {
            return (10 - index) * 10
        }
        return (10 - index) * char.toString().toInt()
    }

    fun isValid(isbn: String): Boolean {
        val validChars = isbn.replace(Regex("[^\\dX]+"), "")
        val validIsbnPattern = Regex("^\\d{9}[\\dX]{1}$")
        if (!validChars.matches(validIsbnPattern)) {
            return false
        }

        val sumOfChars = validChars.toList().mapIndexed { index, char -> findMultiplierForChar(index, char) }.sum()

        return sumOfChars.mod(11) == 0
    }

}
