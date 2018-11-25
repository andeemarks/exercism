class Allergies(private var score: Int) {
    var allergies = mutableSetOf<Allergen?>()

    private val orderedAllergens = hashMapOf(
        Allergen.EGGS.score to Allergen.EGGS,
        Allergen.PEANUTS.score to Allergen.PEANUTS,
        Allergen.SHELLFISH.score to Allergen.SHELLFISH,
        Allergen.STRAWBERRIES.score to Allergen.STRAWBERRIES,
        Allergen.TOMATOES.score to Allergen.TOMATOES,
        Allergen.CHOCOLATE.score to Allergen.CHOCOLATE,
        Allergen.POLLEN.score to Allergen.POLLEN,
        Allergen.CATS.score to Allergen.CATS
    )

    init {
        val keys = orderedAllergens.keys.sorted().reversed()
        keys.forEach { allergenScore ->
            val allergenHitScore = score.div(allergenScore)
            if (allergenHitScore >= 1) {
                allergies.add(orderedAllergens[allergenScore])
                score = calculateRemainingScore(allergenScore, allergenHitScore)
            }
        }
    }

    private fun calculateRemainingScore(key: Int, allergenHitScore: Int): Int {
        return if (score.rem(key) == 0) {
            0
        } else {
            score - (allergenHitScore * orderedAllergens[key]!!.score)
        }
    }

    fun isAllergicTo(allergen: Allergen): Boolean {
        return allergies.contains(allergen)
    }

    fun getList(): List<Allergen> {
        return allergies.reversed().filterNotNull()
    }

}
