class SumOfMultiples {
    companion object {
        fun sum(multiples: Set<Int>, limit: Int): Int {
            val factors: MutableList<Int> = mutableListOf()
            for (i in 1..(limit - 1)) {
                multiples.map { multiple: Int ->
                    if (i >= multiple && i.rem(multiple) == 0) {
                        factors.add(i)
                    }
                }
            }

            return factors.distinct().sum()
        }
    }
}
