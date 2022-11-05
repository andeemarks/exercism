import kotlin.math.ceil
import kotlin.math.sqrt

object CryptoSquare {

    fun ciphertext(plaintext: String): String {
        val chars = plaintext.filter{ it.isLetterOrDigit() }.lowercase()

        if (chars.isEmpty()) {
            return ""
        }

        val numberOfColumns = ceil(sqrt(chars.length.toDouble())).toInt()

        val rows = chars.chunked(numberOfColumns) { it.padEnd(numberOfColumns, ' ') }

        var columns = mutableListOf<String>()
        for (i in 0 until numberOfColumns) {
            val column = rows.map { it[i] }
            columns.add(column.joinToString(""))
        }

        return columns.joinToString(" ")
    }

}
