class Matrix(val matrix: List<List<Int>>) {

    var saddlePoints: Set<MatrixCoordinate> = emptySet()

    init {
        matrix.forEachIndexed { rowIdx: Int, row: List<Int> -> row.forEachIndexed { colIdx: Int, _: Int -> isCoordinateASaddlePoint(MatrixCoordinate(rowIdx, colIdx))}}
    }

    private fun List<List<Int>>.columnForCoordinate(coordinate: MatrixCoordinate): List<Int> {
        return this.map { row: List<Int> -> row[coordinate.col]}
    }

    private fun List<List<Int>>.rowForCoordinate(coordinate: MatrixCoordinate): List<Int> {
        return this[coordinate.row]
    }

    private fun isCoordinateASaddlePoint(coordinate: MatrixCoordinate) {
        var cell: Int = matrix[coordinate.row][coordinate.col]
        var highestInRow = matrix.rowForCoordinate(coordinate).max() == cell
        var lowestInColumn = matrix.columnForCoordinate(coordinate).min() == cell

        if (highestInRow && lowestInColumn) {
            saddlePoints = saddlePoints.plus(coordinate)
        }
    }

}
