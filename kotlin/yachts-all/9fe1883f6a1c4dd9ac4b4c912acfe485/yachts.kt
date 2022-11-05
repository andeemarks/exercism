object Yacht {

    fun solve(category: YachtCategory, vararg dices: Int) = when (category) {
        YachtCategory.ONES -> scoreKind(1, dices)
        YachtCategory.TWOS -> scoreKind(2, dices)
        YachtCategory.THREES -> scoreKind(3, dices)
        YachtCategory.FOURS -> scoreKind(4, dices)
        YachtCategory.FIVES -> scoreKind(5, dices)
        YachtCategory.SIXES -> scoreKind(6, dices)
        YachtCategory.FULL_HOUSE -> scoreFullHouse(dices)
        YachtCategory.FOUR_OF_A_KIND -> scoreFourOfAKind(dices)
        YachtCategory.LITTLE_STRAIGHT -> scoreLittleStraight(dices)
        YachtCategory.BIG_STRAIGHT -> scoreBigStraight(dices)
        YachtCategory.YACHT -> scoreYacht(dices)
        YachtCategory.CHOICE -> dices.sum()
    }

    private fun scoreKind(kind: Int, dices: IntArray) = dices.filter { it == kind }.sum()

    private fun scoreFullHouse(dices: IntArray): Int = dices
            .filter { d -> dices.count { it == d }.let { c -> c == 3 || c == 2 } }
            .run {
                when(size) {
                    5 -> sum()
                    else -> 0
                }
            }

    private fun scoreFourOfAKind(dices: IntArray): Int = dices
            .find { d -> dices.count { it == d } >= 4 }
            .let { (it ?: 0) * 4 }

    private fun scoreBigStraight(dices: IntArray) = when (dices.sum()) {
        20 -> 30
        else -> 0
    }

    private fun scoreLittleStraight(dices: IntArray) = when (dices.sum()) {
        15 -> 30
        else -> 0
    }

    private fun scoreYacht(dices: IntArray) = when {
        dices.any { it != dices[0] } -> 0
        else -> 50
    }
}