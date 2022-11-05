class RotationalCipher {

    val rotationPoint: Int
    var lowerChars: String = "abcdefghijklmnopqrstuvwxyz"
    var lowerTranslations = lowerChars + lowerChars

    constructor(rotationPoint: Int) {
        this.rotationPoint = rotationPoint
    }

    fun encodeChar(c: String): String {
        var matchPosition = lowerChars.indexOf(c)
        if (matchPosition < 0) {
            return c
        }

        val newCharPosition = matchPosition + this.rotationPoint
        
        return lowerTranslations.substring(newCharPosition, newCharPosition + 1)
    }

    fun encodeChar(c: Char): String {
        var encodedCharacter = encodeChar(c.lowercase())

        return if (c.isUpperCase()) encodedCharacter.uppercase() else encodedCharacter
    }

    fun encode(text: String): String {
        return text.map{encodeChar(it)}.joinToString("")
    }
}
