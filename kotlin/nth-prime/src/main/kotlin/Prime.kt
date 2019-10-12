class Prime {
    companion object {
        fun nth(n: Int): Int {
            require (n > 0) {"There is no zeroth prime."}

            var candidate = 1
            var primeCounter = 1
            do {
                if (isPrime(++candidate)) {
                    if (primeCounter++ == n) {
                        return candidate
                    }
                }
            } while (true)

            return candidate
        }

        private fun isPrime(n: Int): Boolean {
            for (possibleFactor in 2..(n/2)) {
                if (n.rem(possibleFactor) == 0) {
                    return false
                }
            }
            return true
        }
    }
}
