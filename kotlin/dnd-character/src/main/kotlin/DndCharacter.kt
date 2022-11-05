import kotlin.random.Random

class DndCharacter {

    val strength: Int = ability()
    val dexterity: Int = ability()
    val constitution: Int = ability()
    val intelligence: Int = ability()
    val wisdom: Int = ability()
    val charisma: Int = ability()
    val hitpoints: Int = 10 + modifier(constitution)

    companion object {

        fun ability(): Int {
            val dieRolls = List(4) { Random.nextInt(1, 7) }

            return dieRolls.sortedDescending().drop(1).sum()
        }

        fun modifier(score: Int): Int = (score - 10).floorDiv(2)
    }

}
