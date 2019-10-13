function findersKeepers<T>(collection: Array<T>, predicate: (x: T) => Boolean, keepOnPredicateMatch: Boolean ): Array<T> {
    let keepers: Array<T> = [];

    collection.forEach(function(item: T) {
        if (predicate(item) == keepOnPredicateMatch) {
            keepers.push(item)
        }
    });

    return keepers;
}

export function keep<T>( collection: Array<T>, predicate: (x: T) => Boolean ): Array<T> {
    return findersKeepers(collection, predicate, true);
}

export function discard<T>( collection: Array<any>, predicate: (x: T) => Boolean ): Array<T> {
    return findersKeepers(collection, predicate, false);
}
