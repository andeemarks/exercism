class Series {
    companion object {
        private fun sliceToListOfDigits(number: String, length: Int): List<Int> {
            return number.substring(0, length).map { digit -> digit.toString().toInt() }
        }

        fun slices(sliceSize: Int, number: String): MutableList<List<Int>> {
            val numberOfSlices = number.length - sliceSize + 1
            val slices: MutableList<List<Int>> = mutableListOf()
            for (i in 0 until numberOfSlices) {
                slices.add(sliceToListOfDigits(number.drop(i), sliceSize))
            }

            return slices
        }
    }
}
