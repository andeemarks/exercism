function accumulate<T>(collection: Array<T>, accumulator: (x: T) => any): Array<T> {
    let results: Array<T> = [];
    collection.forEach(item => results.push(accumulator(item)));

    return results;
};

export default accumulate