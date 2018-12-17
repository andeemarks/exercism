import java.lang.Math.pow

class BaseConverter(private val base: Int, private val numbers: IntArray) {
    init {
        require(base >= 2) { "Bases must be at least 2." }
        require(numbers.isNotEmpty()) { "You must supply at least one digit." }
        require(numbers.none { number: Int -> number >= base }) { "All digits must be strictly less than the base." }
        require(numbers.none { number: Int -> number < 0 }) { "Digits may not be negative." }
        require(numbers.first() > 0 || numbers.size == 1 && numbers.first() == 0) { "Digits may not contain leading zeros." }
    }

    fun convertToBase(baseN: Int): IntArray? {
        require(baseN >= 2) { "Bases must be at least 2." }

        val base10Number: Int = convertToBaseNToBase10()
        val baseNNumbers: List<Int> = convertBase10ToBaseN(baseN, base10Number)

        return baseNNumbers.toIntArray()
    }

    private fun convertToBaseNToBase10(): Int {
        return numbers.reversed().mapIndexed { i: Int, number: Int -> number * pow(base.toDouble(), i.toDouble()).toInt() }.sum()
    }

    private fun convertBase10ToBaseN(baseN: Int, base10Number: Int): List<Int> {
        if (baseN == 10) {
            return base10Number.toString().map { char: Char -> (char - '0') }
        }

        var base10Number1 = base10Number
        var baseNNumbers: List<Int> = emptyList()
        val baseNUnits: List<Int> = computeUnitValuesForBase(baseN, base10Number1)
        baseNUnits.forEach { baseNUnit: Int ->
            val baseNNumber = base10Number1.div(baseNUnit)
            val base10Component: Int = baseNNumber * baseNUnit
            base10Number1 -= base10Component
            baseNNumbers = baseNNumbers.plus(baseNNumber)
        }
        return baseNNumbers
    }

    private fun computeUnitValuesForBase(base: Int, limit: Int): List<Int> {
        var columnValues: List<Int> = listOf(1)
        var limitExceeded = false
        var i = 1
        while (!limitExceeded) {
            val nextColumnValue = pow(base.toDouble(), i.toDouble()).toInt()
            if (nextColumnValue > limit) {
                limitExceeded = true
            } else {
                columnValues = columnValues.plus(nextColumnValue)
                i++
            }
        }

        return columnValues.reversed()
    }
}