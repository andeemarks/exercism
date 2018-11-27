class HandshakeCalculator {
    companion object {
        private fun MutableList<Signal>.addIfMatches(i: Int, signal: Signal) {
            if (i and signal.mask > 0) {
                this.add(signal)
            }
        }

        fun calculateHandshake(i: Int): List<Signal> {
            val handshake = mutableListOf<Signal>()
            handshake.addIfMatches(i, Signal.WINK)
            handshake.addIfMatches(i, Signal.DOUBLE_BLINK)
            handshake.addIfMatches(i, Signal.CLOSE_YOUR_EYES)
            handshake.addIfMatches(i, Signal.JUMP)

            if (i and 16 > 0) {
                return handshake.reversed()
            }

            return handshake
        }
    }
}
