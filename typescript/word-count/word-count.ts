class Words {
    prepWords(words: string): Array<string> {
        return words
            .toLowerCase()
            .split(/(\s+)/)
            .map( it => it.trim())
            .filter( it => it.length > 0 );
    }

    count(words: string): Map<string, number> {
        let counts: Map<string, number> = new Map()
        for (let word of this.prepWords(words)) {
            counts.set(word, (counts.get(word) || 0) + 1);
        }

        return counts;
    }
}

export default Words