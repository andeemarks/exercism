type DNAStrand = string;
type DNANucleotide = "A" | "C" | "G" | "T";
type CountResult = { [N in DNANucleotide]: number; };

class NucleotideCount {
  static nucleotideRunLength(
    strand: DNAStrand,
    nucleotide: DNANucleotide
  ): number {
    return (strand.match(new RegExp(nucleotide, "gi")) || []).length;
  }

  static isDNAStrand(strand: string): strand is DNAStrand {
    return !strand.match(/[^ACGT]/i);
  }

  static nucleotideCounts(strand: string | DNAStrand): CountResult {
    if (!this.isDNAStrand(strand)) {
      throw new Error("Invalid nucleotide in strand");
    }

    return {
      A: this.nucleotideRunLength(strand, "A"),
      C: this.nucleotideRunLength(strand, "C"),
      G: this.nucleotideRunLength(strand, "G"),
      T: this.nucleotideRunLength(strand, "T"),
    };
  }
}

export default NucleotideCount;
