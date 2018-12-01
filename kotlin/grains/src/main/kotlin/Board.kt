import java.math.BigInteger

class Board {
    companion object {
        fun getGrainCountForSquare(i: Int): BigInteger {
            require(i in 1..64) {"Only integers between 1 and 64 (inclusive) are allowed"}

            return BigInteger("" + 2).pow(i - 1)
        }

        fun getTotalGrainCount(): BigInteger {
            var totalGrainCount: BigInteger = BigInteger.ZERO
            for (i: Int in (1..64)) {
                totalGrainCount = totalGrainCount.add(getGrainCountForSquare(i))
            }

            return totalGrainCount
        }
    }
}
