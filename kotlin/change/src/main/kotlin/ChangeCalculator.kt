class ChangeCalculator(private val currency: List<Int>) {

    fun computeMostEfficientChange(grandTotal: Int): List<Int> {
        if (grandTotal == 0) {
            return emptyList()
        }

        if (grandTotal < 0) {
            throw IllegalArgumentException("Negative totals are not allowed.")
        }

        var availableCoins = this.currency.filter { it <= grandTotal }.sorted()

        if (availableCoins.isEmpty()) {
            throw IllegalArgumentException("The total $grandTotal cannot be represented in the given currency.")
        }

        var mostEfficientChange = emptyList<Int>()
        do {
            try {
                val newChange = findChangeFor(grandTotal, availableCoins)
                println(newChange)
                if (mostEfficientChange.isEmpty() || newChange.size < mostEfficientChange.size) {
                    mostEfficientChange = newChange
                }
            } catch (e: IllegalStateException) {
//                Could not solve with this version of availableCoins
            }
            availableCoins = availableCoins.dropLast(1)
        } while (availableCoins.isNotEmpty())

        if (mostEfficientChange.isEmpty()) {
            throw IllegalArgumentException("The total $grandTotal cannot be represented in the given currency.")
        }

        return mostEfficientChange
    }

    private fun findChangeFor(amount: Int, sortedCoins: List<Int>): MutableList<Int> {
        val change = mutableListOf<Int>()
        var remainingAmount = amount
        while (remainingAmount >= sortedCoins.first()) {
            remainingAmount = run {
                val largestCoin = sortedCoins.last { it <= remainingAmount }
                val numberOfLargestCoin = remainingAmount / largestCoin
                change.addAll(List(numberOfLargestCoin) { largestCoin })

                remainingAmount - numberOfLargestCoin * largestCoin
            }
        }

        if (remainingAmount > 0) {
            throw IllegalStateException("No solution for $amount with $sortedCoins")
        }

        return change
    }

}
