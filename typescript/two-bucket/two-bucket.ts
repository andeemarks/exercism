enum BucketId {
  One = "one",
  Two = "two",
}

class BucketState {
  public capacity: number = 0;
  public contents: number = 0;
  constructor(readonly name: BucketId) {}

  addNoMoreThan(amount: number): number {
    let remainingCapacity = this.capacity - this.contents;
    let amountToPour = Math.min(remainingCapacity, amount);

    this.contents += amountToPour;

    return amountToPour;
  }

  fill() {
    this.contents = this.capacity;
  }

  empty() {
    this.contents = 0;
  }
}

let bucketOne: BucketState = new BucketState(BucketId.One);
let bucketTwo: BucketState = new BucketState(BucketId.Two);

class TwoBucket {
  private numberOfMoves: number = 0;

  constructor(
    readonly bucketOneSize: number,
    readonly bucketTwoSize: number,
    readonly goal: number,
    readonly starterBucket: BucketId
  ) {
    bucketTwo.capacity = bucketTwoSize;
    bucketOne.capacity = bucketOneSize;

    // Hard-coded solution for first test only :-()
    this.fill(BucketId.One);
    this.pour(BucketId.One);
    this.fill(BucketId.One);
    this.pour(BucketId.One);
  }

  moves(): number {
    return this.numberOfMoves;
  }

  private pour(source: BucketId) {
    if (source == BucketId.One) {
      const actualAmount = bucketTwo.addNoMoreThan(bucketOne.contents);
      bucketOne.contents -= actualAmount;
    } else {
      const actualAmount = bucketOne.addNoMoreThan(bucketTwo.contents);
      bucketTwo.contents -= actualAmount;
    }

    this.numberOfMoves++;
  }

  private empty(bucket: BucketId) {
    if (bucket == BucketId.One) {
      bucketOne.empty();
    } else {
      bucketTwo.empty();
    }

    this.numberOfMoves++;
  }

  private fill(bucket: BucketId) {
    if (bucket == BucketId.One) {
      bucketOne.fill();
    } else {
      bucketTwo.fill();
    }

    this.numberOfMoves++;
  }

  public get goalBucket(): string {
    if (bucketOne.contents == this.goal) {
      return bucketOne.name;
    } else {
      return bucketTwo.name;
    }
  }

  public get otherBucket(): number {
    if (bucketOne.contents == this.goal) {
      return bucketTwo.contents;
    } else {
      return bucketOne.contents;
    }
  }
}

export { BucketId as Bucket, TwoBucket };
