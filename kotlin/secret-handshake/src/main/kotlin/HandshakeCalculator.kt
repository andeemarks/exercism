class HandshakeCalculator {
    companion object {
        fun addIfMatches(i: Int, signal: Signal, mask: Int, handshake: MutableList<Signal>): MutableList<Signal> {
            if (i and mask > 0) {
                handshake.add(signal)
            }

            return handshake

        }

        fun calculateHandshake(i: Int): List<Signal> {
            var handshake = mutableListOf<Signal>()
            handshake = addIfMatches(i, Signal.WINK, 1, handshake)
            handshake = addIfMatches(i, Signal.DOUBLE_BLINK, 2, handshake)
            handshake = addIfMatches(i, Signal.CLOSE_YOUR_EYES, 4, handshake)
            handshake = addIfMatches(i, Signal.JUMP, 8, handshake)

            if (i and 16 > 0) {
                return handshake.reversed()
            }

            return handshake
        }
    }
}
