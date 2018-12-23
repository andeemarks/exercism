class Dna(dna: String) {
    val nucleotideCounts: MutableMap<Char, Int> = mutableMapOf()

    init {
        require(dna.matches(Regex("[ACGT]*")))
        countNucleotide(dna, 'A')
        countNucleotide(dna, 'C')
        countNucleotide(dna, 'G')
        countNucleotide(dna, 'T')
    }

    private fun countNucleotide(dna: String, nucleotide: Char) {
        nucleotideCounts[nucleotide] = dna.toCharArray().count { char: Char -> char == nucleotide }
    }
}
