class Triplet {
  a: number;
  b: number;
  c: number;

  constructor(a: number, b: number, c: number) {
    this.a = a;
    this.b = b;
    this.c = c;
  }

  product(): number {
    return this.a * this.b * this.c;
  }

  isPythagorean(): boolean {
    return this.a ** 2 + this.b ** 2 == this.c ** 2;
  }

  static where(a: number, b: number = 0, c: number = 0) {
    return [new Triplet(a, b, c)];
  }

  sum(): number {
      return this.a + this.b + this.c;
  }
}

export default Triplet
