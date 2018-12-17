class CollatzCalculator {
    companion object {
        fun computeStepCount(n: Int): Int {
            require(n > 0) { "Only natural numbers are allowed" }

            return calculate(n, 0)
        }

        private fun calculate(n: Int, stepCount: Int): Int {
            return when {
                n == 1 -> stepCount
                n % 2 == 0 -> calculate(n / 2, stepCount + 1)
                else -> calculate(n * 3 + 1, stepCount + 1)
            }
        }
    }
}
