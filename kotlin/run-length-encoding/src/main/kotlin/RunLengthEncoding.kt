object RunLengthEncoding {

    fun encode(input: String): String {
        return input.replace(Regex("([\\w ])\\1*")) { match -> contractRun(match) }
    }

    private fun contractRun(match: MatchResult): String {
        val numberOfRepeats = match.value.length
        val runLength = if (numberOfRepeats > 1) numberOfRepeats.toString() else ""

        return "${runLength}${match.value[0]}"
    }

    fun decode(input: String): String {
        return input.replace(Regex("(\\d+)(.)")) { match -> expandRun(match) }
    }

    private fun expandRun(match: MatchResult): String {
        val (runLength, value) = match.destructured

        return value.repeat(runLength.toInt())
    }
}
