class SpiralMatrix {
    companion object {
        private var matrix: Array<IntArray> = emptyArray()

        fun ofSize(n: Int): Array<IntArray> {
            matrix = Array(n) { IntArray(n) { 0 } }
            var context = Triple(Pair(0, 0), 1, FillDirection.RIGHT)
            do {
                context = fillSegment(context)
            } while (context.nextCellValue <= n * n)

            return matrix
        }

        private fun Array<IntArray>.isUpdatableCell(row: Int, column: Int): Boolean {
            return (row < this.size && row >= 0) && (column < this[row].size && column >= 0) && (this[row][column] == 0)
        }

        private val Triple<Pair<kotlin.Int, kotlin.Int>, kotlin.Int, FillDirection>.direction: FillDirection
            get() = this.third

        private val Triple<Pair<kotlin.Int, kotlin.Int>, kotlin.Int, FillDirection>.nextCellValue: Int
            get() = this.second

        private val Triple<Pair<kotlin.Int, kotlin.Int>, kotlin.Int, FillDirection>.currentCell: Pair<Int, Int>
            get() = this.first

        private fun fillSegment(context: Triple<Pair<Int, Int>, Int, FillDirection>): Triple<Pair<Int, Int>, Int, FillDirection> {
            var row: Int = context.currentCell.second
            var column: Int = context.currentCell.first
            var nextCellValue: Int = context.nextCellValue
            while (matrix.isUpdatableCell(row, column)) {
                matrix[row][column] = nextCellValue
                row += context.direction.yOffset
                column += context.direction.xOffset
                nextCellValue++
            }

            return Triple(Pair(column + context.direction.nextXStart, row + context.direction.nextYStart), nextCellValue, context.direction.next)
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
