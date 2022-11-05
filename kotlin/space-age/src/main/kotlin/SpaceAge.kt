import java.text.DecimalFormat

class SpaceAge(seconds: Int) {
    private val baseline: Double

    init {
        this.baseline = seconds.toDouble() / 31557600
    }

    private fun adjustBaselineBy(adjustment: Double): Double = DecimalFormat("#.##").format(this.baseline / adjustment).toDouble()

    fun onEarth(): Double = adjustBaselineBy(1.0)
    fun onMercury(): Double = adjustBaselineBy(0.2408467)
    fun onVenus(): Double = adjustBaselineBy(0.61519726)
    fun onMars(): Double = adjustBaselineBy(1.8808158)
    fun onJupiter(): Double = adjustBaselineBy(11.862615)
    fun onSaturn(): Double = adjustBaselineBy(29.447498)
    fun onUranus(): Double = adjustBaselineBy(84.016846)
    fun onNeptune(): Double = adjustBaselineBy(164.79132)
}
