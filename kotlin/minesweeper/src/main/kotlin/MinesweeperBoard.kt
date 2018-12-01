class MinesweeperBoard(val boardRows: List<String>) {

    private var boardCells: List<MutableList<Char>>

    init {
        boardCells = boardRows.map { row: String -> row.toMutableList() }
        boardCells.forEachIndexed { x: Int, row: List<Char> ->
            row.forEachIndexed { y: Int, cell: Char ->
                if (cell.isMine()) {
                    updateMineNeighbours(x, y)
                }
            }
        }
    }

    private fun updateMineNeighbours(mineX: Int, mineY: Int) {
        updateMineCount(mineX - 1, mineY)
        updateMineCount(mineX - 1, mineY + 1)
        updateMineCount(mineX - 1, mineY - 1)
        updateMineCount(mineX, mineY - 1)
        updateMineCount(mineX, mineY + 1)
        updateMineCount(mineX + 1, mineY + 1)
        updateMineCount(mineX + 1, mineY - 1)
        updateMineCount(mineX + 1, mineY)
    }

    fun withNumbers(): List<String> {
        return boardCells.map { row: List<Char> -> row.joinToString("") }
    }

    private fun updateMineCount(x: Int, y: Int) {
        try {
            if (!boardCells[x][y].isMine()) {
                if (boardCells[x][y].isEmpty()) {
                    boardCells[x][y] = '1'
                } else {
                    boardCells[x][y] = (boardCells[x][y].toInt() + 1).toChar()
                }
            }
        } catch (e: java.lang.IndexOutOfBoundsException) {
        }
    }
}


private fun Char.isEmpty(): Boolean {
    return this == ' '
}

private fun Char.isMine(): Boolean {
    return this == '*'
}
