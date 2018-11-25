import java.time.LocalDate
import java.time.LocalDateTime

class Gigasecond {
    var date: LocalDateTime = LocalDateTime.now()

    constructor(of: LocalDateTime) { date = of.plusSeconds(1000000000) }
    constructor(of: LocalDate) : this(of.atStartOfDay())
}