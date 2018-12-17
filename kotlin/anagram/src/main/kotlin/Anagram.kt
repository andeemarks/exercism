class Anagram(private val word: String) {
    fun match(candidates: List<String>): Set<String> {

        return candidates.filter { candidate: String -> isAnagram(candidate) }.toSet()
    }

    private fun isAnagram(candidate: String): Boolean {
        val wordChars = word.toLowerCase().toCharArray().toList().sorted()
        val candidateChars = candidate.toLowerCase().toCharArray().toList().sorted()

        return word.toLowerCase() != candidate.toLowerCase() && wordChars == candidateChars
    }
}
