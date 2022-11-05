import kotlin.math.pow

object ArmstrongNumber {

    fun check(input: Int): Boolean {
        val numberOfDigits = input.toString().length
        val sumOfPowers = input.toString().map { digit -> digit.toString().toDouble().pow(numberOfDigits) }.sum()

        return sumOfPowers.toInt() == input
    }

}
