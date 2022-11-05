class Scale(private val tonic: String) {
    val C_MAJOR_SCALE = listOf("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B")
    val TWO_COMPLETE_SCALES = C_MAJOR_SCALE + C_MAJOR_SCALE

    fun mapNote(note: String): String {
        val noteEquivalents =
                hashMapOf("Bb" to "A#", "Db" to "C#", "Eb" to "D#", "Gb" to "F#", "Ab" to "G#")

        val mappedNote = noteEquivalents.get(note)

        if (mappedNote != null) return mappedNote else return note
    }

    fun properCaseNote(note: String): String {
        if (note.length == 2) return note.get(0).toUpperCase().toString() + note.get(1).toString()
        else return note.toUpperCase()
    }

    fun normaliseTonic(tonic: String): String {
        val normalisedTonic = properCaseNote(tonic)

        return mapNote(normalisedTonic)
    }

    fun chromatic(): List<String> {
        val normalisedTonic = normaliseTonic(this.tonic)
        val positionOfTonic = TWO_COMPLETE_SCALES.indexOf(normalisedTonic)
        val NOTES_IN_SCALE = 12

        return TWO_COMPLETE_SCALES.subList(positionOfTonic, positionOfTonic + NOTES_IN_SCALE)
    }

    fun interval(intervals: String): List<String> {
        val intervalIndices: List<Int> =
                intervals
                        .replace('M', '2')
                        .replace('m', '1')
                        .replace('A', '3')
                        .split("")
                        .filterNot { it.isBlank() }
                        .map { it.toInt() }

        val scale = chromatic()

        val scaleIntervals =
                intervalIndices.mapIndexed { i, _ ->
                    if (i == 0) scale[0] else scale[intervalIndices.subList(0, i).sum()]
                }

        return scaleIntervals
    }
}
