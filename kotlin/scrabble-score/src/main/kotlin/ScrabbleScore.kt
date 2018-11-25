class ScrabbleScore {
    companion object {
        fun scoreWord(letters: String): Int {
            val scores = letters.map { letter: Char -> scoreForLetter(letter) }

            return scores.sum()
        }

        private fun scoreForLetter(letter: Char): Int {
            return when(letter.toUpperCase()) {
                'D', 'G' -> 2
                'B', 'C', 'M', 'P' -> 3
                'F', 'H', 'V', 'W', 'Y' -> 4
                'K' -> 5
                'J', 'X' -> 8
                'Q', 'Z' -> 10
                else -> 1
            }
        }
    }
}
