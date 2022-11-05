data class ComplexNumber(val real: Double = 0.0, val imag: Double = 0.0) {
    // |z| = sqrt(a^2 + b^2)
    var abs: Double = Math.sqrt(real.sqr() + imag.sqr())
}

// a - b * i
fun ComplexNumber.conjugate(): ComplexNumber {
    return ComplexNumber(real, imag * -1)
}

operator fun ComplexNumber.plus(other: ComplexNumber): ComplexNumber {
    return ComplexNumber(real + other.real, imag + other.imag)
}

operator fun ComplexNumber.minus(other: ComplexNumber): ComplexNumber {
    return ComplexNumber(real - other.real, imag - other.imag)
}

// (a + i * b) * (c + i * d) = (a * c - b * d) + (b * c + a * d) * i.
operator fun ComplexNumber.times(other: ComplexNumber): ComplexNumber {
    return ComplexNumber(
            real * other.real - imag * other.imag,
            imag * other.real + real * other.imag
    )
}

// (a + i * b) / (c + i * d) = (a * c + b * d)/(c^2 + d^2) + (b * c - a * d)/(c^2 + d^2) * i.
operator fun ComplexNumber.div(other: ComplexNumber): ComplexNumber {
    val sumOfSquares = other.real.sqr() + other.imag.sqr()

    return ComplexNumber(
            (real * other.real + imag * other.imag) / sumOfSquares,
            (imag * other.real - real * other.imag) / sumOfSquares
    )
}

// e^(a + i * b) = e^a * e^(i * b)
// e^(i * b) = cos(b) + i * sin(b)
fun exponential(other: ComplexNumber): ComplexNumber {
    val euler = Math.cos(other.imag) + Math.sin(other.imag)

    return ComplexNumber(Math.exp(other.real) * euler)
}

fun Double.sqr(): Double {
    return Math.pow(this, 2.0)
}
