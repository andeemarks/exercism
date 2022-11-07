object WordCount {

    private fun clean(word: String): String {
        val nonWordChars = Regex("[^a-zA-Z0-9']")

        return word.trim().removePrefix("'").removeSuffix("'").replace(nonWordChars, "").lowercase()
    }

    fun phrase(phrase: String): Map<String, Int> {
        val wordSeparators = Regex("[\\n ,]")
        val words = phrase.split(wordSeparators).filter { it.isNotEmpty() }.map { clean(it) }

        return words.groupBy { it }.mapValues { it.value.size }
    }
}
