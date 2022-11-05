import kotlin.random.Random

val nameHistory = mutableSetOf<String>()

class Robot {

    val alphabet = ('A'..'Z').toMutableList()

    var name: String = generateName()

    fun generateName(): String {
        var newName: String
        do {
            newName = "${alphabet.random()}${alphabet.random()}${"%03d".format(Random.nextInt(1000))}"
        } while (nameHistory.contains(newName))

        nameHistory.add(newName)

        return newName
    }

    fun reset() {
        this.name = generateName()
        nameHistory.clear()
    }
}
