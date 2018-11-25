class DiamondPrinter {
    fun printToList(c: Char): List<String> {
        val halfHeight = alphabet.indexOf(c)
        val rowTrimSize = alphabet.size - halfHeight - 1
        val diamond: MutableList<String> = mutableListOf()

        for (i in 0 until halfHeight + 1) {
            diamond.add(rowTemplate.replace(Regex("[^" + alphabet[i] + "]"), " ").drop(rowTrimSize).dropLast(rowTrimSize))
        }
        diamond.addAll(diamond.dropLast(1).reversed())

        return diamond
    }

    private val alphabet = listOf('A'..'Z').flatten()
    private val rowTemplate = (alphabet.reversed() + alphabet.drop(1)).joinToString("")
}
