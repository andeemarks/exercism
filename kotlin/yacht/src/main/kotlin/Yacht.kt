object Yacht {

    fun solve(category: YachtCategory, vararg dices: Int): Int {
        val groupedRolls = dices.groupBy { it }
        val groupsOfFour = groupedRolls.values.filter { it -> it.size >= 4 }
        val sortedRolls = dices.sorted()
        val LITTLE_STRAIGHT = listOf(1, 2, 3, 4, 5)
        val BIG_STRAIGHT = listOf(2, 3, 4, 5, 6)

        return when (category) {
            YachtCategory.YACHT -> if (groupedRolls.size == 1) 50 else 0
            YachtCategory.ONES -> sumAndMultiply(dices, 1, 1)
            YachtCategory.TWOS -> sumAndMultiply(dices, 2, 2)
            YachtCategory.FOURS -> sumAndMultiply(dices, 4, 4)
            YachtCategory.THREES -> sumAndMultiply(dices, 3, 3)
            YachtCategory.FIVES -> sumAndMultiply(dices, 5, 5)
            YachtCategory.SIXES -> sumAndMultiply(dices, 6, 6)
            YachtCategory.FULL_HOUSE ->
                    if (groupedRolls.values.filter { it -> it.size == 3 }.size == 1) dices.sum()
                    else 0
            YachtCategory.FOUR_OF_A_KIND ->
                    if (groupsOfFour.size == 1) groupsOfFour.first().take(4).sum() else 0
            YachtCategory.LITTLE_STRAIGHT -> if (sortedRolls == LITTLE_STRAIGHT) 30 else 0
            YachtCategory.BIG_STRAIGHT -> if (sortedRolls == BIG_STRAIGHT) 30 else 0
            YachtCategory.CHOICE -> dices.sum()
        }
    }

    fun sumAndMultiply(dices: IntArray, valueToSum: Int, multiple: Int): Int {
        return dices.filter { it -> it == valueToSum }.size * multiple
    }
}
