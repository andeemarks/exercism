class BaseConverter(base: Int, val numbers: IntArray) {
    init {
        require(base >= 2) {"Bases must be at least 2."}
        require(numbers.isNotEmpty()) {"You must supply at least one digit."}
        require(numbers.none { number: Int -> number >= base }) {"All digits must be strictly less than the base."}
        require(numbers.none { number: Int -> number < 0 }) {"Digits may not be negative."}
        require(numbers.first() > 0 || numbers.size == 1 && numbers.first() == 0) {"Digits may not contain leading zeros."}
    }

    fun convertToBase(destinationBase: Int): IntArray? {
        require(destinationBase >= 2) {"Bases must be at least 2."}

        val base10Numbers: List<Int> = numbers.reversed().mapIndexed { i: Int, number: Int -> number * Math.pow(number.toDouble(), i.toDouble()).toInt() }
        println(base10Numbers)

        return base10Numbers.toIntArray()
    }
}