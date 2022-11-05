object Atbash {

    private const val ALPHABET = "abcdefghijklmnopqrstuvwxyz"
    private val REVERSABET = ALPHABET.reversed()

    fun encode(s: String): String  = groupByLength(translate(s))
    fun decode(s: String): String = translate(s)

    private fun translate(s: String): String {
        return s.filter { it.isLetterOrDigit() }.map { translateChar(it) }.joinToString("")
    }

    private fun translateChar(c: Char): Char {
        val charPosition = ALPHABET.indexOf(c.lowercaseChar())
        val isCharacter = charPosition >= 0
        return if (isCharacter) {
            REVERSABET[charPosition]
        } else {
            c
        }
    }

    private fun groupByLength(s: String): String {
        return s.chunked(5) { it.toString() }.joinToString(" ")
    }
}
