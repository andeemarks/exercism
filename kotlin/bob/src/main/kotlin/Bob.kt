object Bob {
    fun hey(input: String): String {
        val cleanInput = input.trim()
        val isShouted = cleanInput.uppercase() == cleanInput
        val hasLetters = cleanInput.any { it -> it.isLetter() }
        val isQuestion = cleanInput.endsWith("?")
        val isStatement = cleanInput.endsWith("!")

        return when {
            cleanInput.isEmpty() -> "Fine. Be that way!"
            isQuestion && hasLetters && isShouted -> "Calm down, I know what I'm doing!"
            isQuestion -> "Sure."
            isShouted && (isStatement || hasLetters) -> "Whoa, chill out!"
            else -> "Whatever."
        }
    }
}
