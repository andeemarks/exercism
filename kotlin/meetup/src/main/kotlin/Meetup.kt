import java.time.DayOfWeek
import java.time.LocalDate

class Meetup(private val monthIdx: Int, private val year: Int) {
    fun day(dayOfWeek: DayOfWeek, schedule: MeetupSchedule): LocalDate? {
        val daysInMonth = populateDaysForMonth(LocalDate.of(year, monthIdx, 1))

        return when (schedule) {
            MeetupSchedule.FIRST -> daysInMonth.filter { day: LocalDate -> day.dayOfWeek == dayOfWeek }[0]
            MeetupSchedule.SECOND -> daysInMonth.filter { day: LocalDate -> day.dayOfWeek == dayOfWeek }[1]
            MeetupSchedule.THIRD -> daysInMonth.filter { day: LocalDate -> day.dayOfWeek == dayOfWeek }[2]
            MeetupSchedule.FOURTH -> daysInMonth.filter { day: LocalDate -> day.dayOfWeek == dayOfWeek }[3]
            MeetupSchedule.LAST -> daysInMonth.last { day: LocalDate -> day.dayOfWeek == dayOfWeek }
            MeetupSchedule.TEENTH -> daysInMonth.first { day: LocalDate -> day.dayOfWeek == dayOfWeek && day.dayOfMonth >= 13 && day.dayOfMonth <= 19 }
        }
    }

    private fun populateDaysForMonth(date: LocalDate): List<LocalDate> {
        var daysInMonth = emptyList<LocalDate>()
        for (i in 1..date.lengthOfMonth()) {
            daysInMonth = daysInMonth.plusElement(LocalDate.of(year, date.monthValue, i))
        }
        return daysInMonth
    }

}
