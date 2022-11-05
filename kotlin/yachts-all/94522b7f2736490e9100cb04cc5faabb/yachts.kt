import YachtCategory.*

object Yacht {

    fun solve(category: YachtCategory, vararg dices: Int): Int {
        require(dices.size == 5) { "invalid number of dices" }
        return when (category) {
            YACHT -> if (dices.all { it == dices[0] }) 50 else 0

            ONES, TWOS, THREES, FOURS, FIVES, SIXES  -> dices.filter { it == category.ordinal }.sum()

            FULL_HOUSE -> {
                val occurrences = countOccurrences(dices)
                if ((occurrences.any { it.value == 3}) and (occurrences.any { it.value == 2 }))
                    dices.sum()
                else
                    0
            }
            FOUR_OF_A_KIND -> {
                val maxEntry = countOccurrences(dices).maxBy { it.value }
                if ((maxEntry != null) && (maxEntry.value >= 4))
                    maxEntry.key * 4
                else
                    0
            }

            LITTLE_STRAIGHT -> if (dices.sorted() == (1..5).toList()) 30 else 0

            BIG_STRAIGHT -> if (dices.sorted() == (2..6).toList()) 30 else 0

            CHOICE -> dices.sum()
            else -> 0
        }
    }

    private fun countOccurrences(dices: IntArray) = dices.asList().groupingBy { it }.eachCount()
}