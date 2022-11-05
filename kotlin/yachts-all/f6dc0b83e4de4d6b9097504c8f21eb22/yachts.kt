import Yacht.Companion.Companion.bigStraight
import Yacht.Companion.Companion.fullHouseFrequencySet
import Yacht.Companion.Companion.littleStraight
import YachtCategory.*

object Yacht {

    fun solve(category: YachtCategory, vararg dices: Int): Int {
        return when (category) {
            YACHT -> if (dices.drop(1).all { it == dices.first() }) 50 else 0
            ONES -> countScore(dices, 1)
            TWOS -> countScore(dices, 2)
            THREES -> countScore(dices, 3)
            FOURS -> countScore(dices, 4)
            FIVES -> countScore(dices, 5)
            SIXES -> countScore(dices, 6)

            FULL_HOUSE -> {
                val frequencyMap = frequencyMap(dices)

                if (frequencyMap.size == 2 && fullHouseFrequencySet.contains(frequencyMap.values.first())) {
                    dices.sum()
                } else 0
            }

            FOUR_OF_A_KIND -> {
                val frequencyMap = frequencyMap(dices)

                if (frequencyMap.size in 1 .. 2) {
                    frequencyMap.entries.firstOrNull { it.value >= 4 }?.let { it.key * 4 } ?: 0
                } else 0
            }

            LITTLE_STRAIGHT -> if (dices.toHashSet().containsAll(littleStraight)) 30 else 0
            BIG_STRAIGHT -> if (dices.toHashSet().containsAll(bigStraight)) 30 else 0
            CHOICE -> dices.sum()
        }
    }

    private fun frequencyMap(dices: IntArray): HashMap<Int, Int> {
        val map = hashMapOf<Int, Int>()
        dices.forEach { map.computeIfPresent(it) { _, u -> u + 1 } ?: run { map[it] = 1} }
        return map
    }

    private fun countScore(dices: IntArray, value: Int) = dices.count { it == value } * value

    private class Companion {
        companion object {
            val littleStraight = hashSetOf(1, 2, 3, 4, 5)
            val bigStraight = hashSetOf(2, 3, 4, 5, 6)
            val fullHouseFrequencySet = hashSetOf(2, 3)
        }
    }
}