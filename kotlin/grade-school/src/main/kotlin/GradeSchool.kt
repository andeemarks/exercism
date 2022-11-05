class School {

    private var grades: Map<Int, List<String>> = mutableMapOf()

    fun add(student: String, grade: Int) {
        val studentsInGrade = this.grades.getOrDefault(grade, mutableListOf())
        val updatedStudents = studentsInGrade.plus(student).sorted()

        this.grades = this.grades.plus(Pair(grade, updatedStudents))
    }

    fun grade(grade: Int): List<String> = this.grades.getOrDefault(grade, emptyList())

    fun roster(): List<String> = this.grades.toSortedMap().values.flatten()
}
