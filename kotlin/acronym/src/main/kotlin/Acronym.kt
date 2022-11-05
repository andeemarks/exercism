object Acronym {
    fun generate(phrase: String) : String {
        val words = phrase.split(" ", "-", "_").filterNot {it.length <= 0 }

        return words.map{ it[0].uppercase() }.joinToString("")
    }
}
