object Wordy {
    val noOperatorQuestion = """^What is (\d+)\?""".toRegex()
    val singleOperatorQuestion = """^What is (-?\d+) ([\w ]+) (-?\d+)\?""".toRegex()
    val powerQuestion = """^What is (-?\d+) raised to the (-?\d+)th power\?""".toRegex()
    val doubleOperatorQuestion =
            """^What is (-?\d+) ([\w ]+) (-?\d+) ([\w ]+) (-?\d+)\?""".toRegex()

    fun answer(input: String): Int {
        when (true) {
            doubleOperatorQuestion.containsMatchIn(input) ->
                    return handleDoubleOperatorQuestion(input)
            powerQuestion.containsMatchIn(input) -> return handlePowerOperatorQuestion(input)
            singleOperatorQuestion.containsMatchIn(input) ->
                    return handleSingleOperatorQuestion(input)
            noOperatorQuestion.containsMatchIn(input) -> return handleNoOperatorQuestion(input)
        }
        throw IllegalArgumentException()
    }

    fun handleNoOperatorQuestion(input: String): Int {
        val components = noOperatorQuestion.find(input)
        val (operand) = components!!.destructured

        return operand.toInt()
    }

    fun handleSingleOperatorQuestion(input: String): Int {
        val components = singleOperatorQuestion.find(input)
        val (operand1, operator, operand2) = components!!.destructured

        return calculate(operand1.toInt(), operator, operand2.toInt())
    }

    fun handlePowerOperatorQuestion(input: String): Int {
        val components = powerQuestion.find(input)
        val (operand, power) = components!!.destructured

        return calculate(operand.toInt(), "power", power.toInt())
    }

    fun handleDoubleOperatorQuestion(input: String): Int {
        val components = doubleOperatorQuestion.find(input)
        val (operand1, operator1, operand2, operator2, operand3) = components!!.destructured

        val interim = calculate(operand1.toInt(), operator1, operand2.toInt())
        return calculate(interim, operator2, operand3.toInt())
    }

    fun calculate(operand1: Int, operator: String, operand2: Int): Int {
        when (operator) {
            "plus" -> return operand1 + operand2
            "minus" -> return operand1 - operand2
            "multiplied by" -> return operand1 * operand2
            "divided by" -> return operand1 / operand2
            "power" -> return Math.pow(operand1.toDouble(), operand2.toDouble()).toInt()
            else -> { // Note the block
                throw IllegalArgumentException()
            }
        }
    }
}
