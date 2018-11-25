class PigLatin {
    companion object {

        private fun firstMatchingSound(sounds: List<String>, word: String): String = try { sounds.first { prefix -> word.startsWith(prefix) } } catch (e: NoSuchElementException) { "" }
        private fun firstMatchingVowelSound(word: String): String = firstMatchingSound(vowelSounds, word)
        private fun firstMatchingConsonantSound(word: String): String = firstMatchingSound(consonantSounds, word)

        private fun translateWord(word: String): String {
            val vowelSound = firstMatchingVowelSound(word)
            if (!vowelSound.isEmpty()) {
                return word + suffix
            }

            val consonantSound = firstMatchingConsonantSound(word)
            if (!consonantSound.isEmpty()) {
                if (word.drop(consonantSound.length).startsWith("qu")) {
                    val prefixLength = consonantSound.length + "qu".length
                    return word.drop(prefixLength) + word.take(prefixLength) + suffix
                }
                return word.drop(consonantSound.length) + word.take(consonantSound.length) + suffix
            }

            return word
        }

        fun translate(s: String): String {
            val words = s.split(Regex(" "))
            val translatedWords = words.map { word -> translateWord(word)}

            return translatedWords.joinToString(" ")
        }
    }
}

const val suffix = "ay"
val consonantSounds = listOf("sch", "thr", "ch", "th", "qu", "rh", "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z")
val vowelSounds = listOf("a", "e", "i", "o", "u", "xr", "yt")