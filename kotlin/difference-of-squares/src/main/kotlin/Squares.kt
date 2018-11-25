class Squares(val limit: Int) {
    fun squareOfSum(): Int {
        val sum = (1..limit).sum()

        return sum.times(sum)
    }

    fun sumOfSquares(): Int {
        val sum = (1..limit).sumBy { i -> i * i }

        return sum
    }

    fun difference(): Int {
        return squareOfSum() - sumOfSquares()
    }
}