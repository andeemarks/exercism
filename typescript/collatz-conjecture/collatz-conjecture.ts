class CollatzConjecture {
    static steps( start: number ): number {
        if (start <= 0) {
            throw new Error('Only positive numbers are allowed')
        }

        let iterations: number = 0
        for (let n = start; n != 1; iterations++) {
            n = (n % 2 == 0) ? n / 2 : n * 3 + 1
        }

        return iterations
    }
}

export default CollatzConjecture