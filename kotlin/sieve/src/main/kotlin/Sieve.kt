object Sieve {
    fun primesUpTo(upperBound: Int): List<Int> {
        var range = 2..upperBound
        var primes = mutableListOf<Int>()
        for (number in range) {
            primes = range.mapIndexed { i, it -> if (numberIsMarked(primes, i) || ((it > number) && (it % number == 0))) 0 else it }.toMutableList()
        }
        return primes.filter { it != 0 }
    }

    private fun numberIsMarked(primes: MutableList<Int>, i: Int) = (primes.size > i && primes[i] == 0)
}
