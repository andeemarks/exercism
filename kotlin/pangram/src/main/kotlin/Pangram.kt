class Pangram {
    companion object {

        fun isPangram(input: String): Boolean {
            val uniqueInputChars = input.toLowerCase().replace(Regex("[^a-z]"), "").toHashSet()

            return uniqueInputChars.size >= 26

        }
    }
}