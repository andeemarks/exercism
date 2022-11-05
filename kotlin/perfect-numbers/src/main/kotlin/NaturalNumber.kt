import java.util.*

enum class Classification {
    DEFICIENT, PERFECT, ABUNDANT
}

fun classify(naturalNumber: Int): Classification {
    require(naturalNumber > 0) {}

    val factors: List<Int> = factorsOf(naturalNumber)
    val sumOfFactors = factors.sum()

    return when {
        sumOfFactors == naturalNumber -> Classification.PERFECT
        sumOfFactors < naturalNumber -> Classification.DEFICIENT
        else -> Classification.ABUNDANT
    }
}

private fun factorsOf(number: Int): List<Int> {
    return (1..number / 2).filter { number % it == 0 }
}
