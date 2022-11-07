class Matrix(matrixAsString: String) {

    private val rows: List<String> = matrixAsString.split("\n")

    fun column(colNr: Int): List<Int> {
        return rows.map { it.split(" ")[colNr - 1].toInt()}
    }

    fun row(rowNr: Int): List<Int> {
        return rows[rowNr - 1].split(" ").map{ it.toInt() }
    }
}
