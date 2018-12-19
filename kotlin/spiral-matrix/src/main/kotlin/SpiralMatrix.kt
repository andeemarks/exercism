class SpiralMatrix {
    companion object {
        private var matrix: Array<IntArray> = emptyArray()
        private var fillDirection = FillDirection.DOWN

        fun ofSize(n: Int): Array<IntArray> {
            val numbers = ((n + 1)..(n * n)).toList()
            matrix = Array(n) { IntArray(n, { it + 1 }) }
            fillDirection = FillDirection.DOWN
            var currentCell: Pair<Int, Int> = Pair(n - 1, 1)
            var segmentSize = n - 1
            var nextNumber = n + 1
            while (segmentSize >= 1) {
                currentCell = fillSegment(currentCell, nextNumber..(nextNumber + segmentSize - 1))
                fillDirection = fillDirection.next
                nextNumber += segmentSize

                currentCell = fillSegment(currentCell, nextNumber..(nextNumber + segmentSize - 1))
                fillDirection = fillDirection.next
                nextNumber += segmentSize

                segmentSize--
            }

            return matrix
        }

        private fun fillSegment(start: Pair<Int, Int>, numbers: IntRange): Pair<Int, Int> {
            var row = start.second
            var column = start.first
            for (i in numbers) {
                matrix[row][column] = i
                row += fillDirection.yOffset
                column += fillDirection.xOffset
            }

            return Pair(column + fillDirection.nextXStart, row + fillDirection.nextYStart)
        }

    }
}

enum class FillDirection(val xOffset: Int, val yOffset: Int, val nextXStart: Int, val nextYStart: Int) {
    RIGHT(1, 0, -1, 1) {
        override val next: FillDirection
            get() {
                return DOWN
            }
    },
    DOWN(0, 1, -1, -1) {
        override val next: FillDirection
            get() {
                return LEFT
            }
    },
    LEFT(-1, 0, 1, -1) {
        override val next: FillDirection
            get() {
                return UP
            }
    },
    UP(0, -1, 1, 1) {
        override val next: FillDirection
            get() {
                return RIGHT
            }
    };

    abstract val next: FillDirection
}
