class KindergartenGarden(private val diagram: String) {

    val STUDENTS =
            listOf(
                    "Alice",
                    "Bob",
                    "Charlie",
                    "David",
                    "Eve",
                    "Fred",
                    "Ginny",
                    "Harriet",
                    "Ileana",
                    "Joseph",
                    "Kincaid",
                    "Larry")
    val PLANTS = hashMapOf("R" to "radishes", "C" to "clover", "G" to "grass", "V" to "violets")

    fun plantOrError(row: List<String>, position: Int): String {
        val plant = PLANTS.get(row[position])
        if (plant == null) {
            throw IllegalStateException("Cannot resolve plant at ${position} in ${row.toString()}")
        }

        return plant
    }

    fun getPlantsOfStudent(student: String): List<String> {
        val studentPlantPosition = STUDENTS.indexOf(student)

        val rows = this.diagram.split("\n")
        val firstRowPlants = rows[0].split("").filterNot({ it -> it == "" })
        val secondRowPlants = rows[1].split("").filterNot({ it -> it == "" })

        return listOf(
                plantOrError(firstRowPlants, studentPlantPosition * 2),
                plantOrError(firstRowPlants, studentPlantPosition * 2 + 1),
                plantOrError(secondRowPlants, studentPlantPosition * 2),
                plantOrError(secondRowPlants, studentPlantPosition * 2 + 1))
    }
}
