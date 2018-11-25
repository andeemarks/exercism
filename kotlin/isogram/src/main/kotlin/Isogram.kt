class Isogram {
    companion object {
        fun isIsogram(s: String): Boolean {
            val justChars = s.toLowerCase().replace(Regex("[^a-z]"), "")
            val uniqueChars = justChars.toHashSet()

            return uniqueChars.size == justChars.length
        }
    }
}
