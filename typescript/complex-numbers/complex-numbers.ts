class ComplexNumber {
  public readonly abs: number;

  constructor(readonly real: number, readonly imag: number) {
    this.abs = Math.sqrt(real * real + imag * imag);
  }

  get exp(): ComplexNumber {
    return new ComplexNumber(
      Math.exp(this.real) * Math.cos(this.imag),
      Math.sin(this.imag)
    );
  }

  get conj(): ComplexNumber {
    return new ComplexNumber(this.real, (this.imag == 0 ? 0 : -1 * this.imag));
  }

  add(cn: ComplexNumber): ComplexNumber {
    return new ComplexNumber(this.real + cn.real, this.imag + cn.imag);
  }

  sub(cn: ComplexNumber): ComplexNumber {
    return new ComplexNumber(this.real - cn.real, this.imag - cn.imag);
  }

  mul(cn: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      this.real * cn.real - this.imag * cn.imag,
      this.imag * cn.real + this.real * cn.imag
    );
  }

  div(cn: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      (this.real * cn.real + this.imag * cn.imag) /
        (cn.real * cn.real + cn.imag * cn.imag),
      (this.imag * cn.real - this.real * cn.imag) /
        (cn.real * cn.real + cn.imag * cn.imag)
    );
  }
}

export default ComplexNumber;
