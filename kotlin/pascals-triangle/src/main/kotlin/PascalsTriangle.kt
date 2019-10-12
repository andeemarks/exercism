class PascalsTriangle {
    companion object {
        fun computeTriangle(size: Int): List<List<Int>> {
            require(size >= 0) { "Rows can't be negative!" }

            val result: MutableList<List<Int>> = List(size) { row: Int ->
                List(row + 1) { 1 }
            }.toMutableList()


            result.forEachIndexed { rowIndex: Int, row: List<Int> ->
                result[rowIndex] = row.mapIndexed { columnIndex: Int, _ ->
                    if (columnIndex == 0 || columnIndex == row.size - 1) {
                        1
                    } else {
                        result[rowIndex - 1][columnIndex] + result[rowIndex - 1][columnIndex - 1]
                    }
                }
            }

            return result
        }
    }
}