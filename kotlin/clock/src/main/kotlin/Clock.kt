class Clock(private var hours: Int, private var minutes: Int) {
    fun add(minutes: Int) {
        this.minutes += minutes
        calcHours()
        calcMinutes()
    }

    override fun toString(): String = "%02d:%02d".format(hours, minutes)

    init {
        add(0)
    }

    private fun calcMinutes() {
        minutes = minutes.rem(60)

        if (minutes < 0) {
            minutes += 60
            rollBackHourIfNeeded()
        }
    }

    private fun rollBackHourIfNeeded() {
        if (hours == 0) {
            hours = 23
        } else {
            hours--
        }
    }

    private fun calcHours() {
        val hourAdjustment = this.minutes.div(60)
        hours += hourAdjustment

        hours = hours.rem(24)

        if (hours < 0) {
            hours += 24
        }
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as Clock

        if (hours != other.hours) return false
        if (minutes != other.minutes) return false

        return true
    }

    override fun hashCode(): Int {
        var result = hours
        result = 31 * result + minutes
        return result
    }

}
