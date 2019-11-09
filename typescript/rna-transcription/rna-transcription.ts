const substitutions = llnew Map([['C', 'G'], ['G', 'C'], ['A', 'U'], ['T', 'A']]);

class Transcriptor {
    transcriber (_: string, letter: string, ): string {
        let substitution = substitutions.get(letter);
        if (substitution) {
            return substitution;
        }

        throw new Error('Invalid input DNA.');
      };

    toRna( input: string ): string {
        return input.replace( /([A-Z])/g, this.transcriber);
    }
};

export default Transcriptor