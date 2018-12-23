class PhoneNumber {
    constructor(phoneNumber: String) {
        val invalidAreaCode = Regex("\\(([01]\\d\\d)\\)\\s(\\d\\d\\d)-(\\d\\d\\d\\d)").matches(phoneNumber)
        val invalidExchangeCode = Regex("\\((\\d\\d\\d)\\)\\s([01]\\d\\d)-(\\d\\d\\d\\d)").matches(phoneNumber)
        val cleanedNumber: String = phoneNumber.replace(Regex("[()+\\- .]*"), "")
        val firstNumber: Char = cleanedNumber.first()

        number = when {
            invalidAreaCode -> null
            invalidExchangeCode -> null
            cleanedNumber.count { digit: Char -> digit.isDigit() } != cleanedNumber.length -> null
            cleanedNumber.length == 9 || cleanedNumber.length > 11 -> null
            cleanedNumber.length == 11 && firstNumber != '1' -> null
            cleanedNumber.length == 11 && firstNumber == '1' -> cleanedNumber.drop(1)
            firstNumber == '0' -> null
            else -> cleanedNumber
        }

    }

    var number: String? = null
}
