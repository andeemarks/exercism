using System;
using System.Linq;
using System.Collections.Generic;

class LocationVariant
{
    public string utcOffset;
    public string timezoneId;
    public string cultureName;

}

public enum Location
{
    NewYork,
    London,
    Paris
}

public enum AlertLevel
{
    Early,
    Standard,
    Late
}

public static class Appointment
{
    private static Dictionary<Location, LocationVariant> variants = new Dictionary<Location, LocationVariant>();

    static Appointment()
    {
        variants.Add(Location.London, new LocationVariant { utcOffset = "+1:00", timezoneId = "GMT Standard Time", cultureName = "en-GB" });
        variants.Add(Location.Paris, new LocationVariant { utcOffset = "+2:00", timezoneId = "Romance Standard Time", cultureName = "fr-FR" });
        variants.Add(Location.NewYork, new LocationVariant { utcOffset = "-4:00", timezoneId = "US Eastern Standard Time", cultureName = "en-US" });
    }

    public static DateTime ShowLocalTime(DateTime dtUtc)
    {
        return dtUtc + TimeZoneInfo.Local.GetUtcOffset(dtUtc);
    }

    public static DateTime Schedule(string appointmentDateDescription, Location location)
    {
        var locationToUtcOffset = variants[location].utcOffset;

        return DateTime.Parse($"{appointmentDateDescription} {locationToUtcOffset}", null, System.Globalization.DateTimeStyles.AdjustToUniversal);
    }

    public static DateTime GetAlertTime(DateTime appointment, AlertLevel alertLevel)
    {
        var alertMinutesOffset = alertLevel switch
        {
            AlertLevel.Early => 24 * 60,
            AlertLevel.Standard => 60 + 45,
            AlertLevel.Late => 30,
            _ => throw new ArgumentException()

        };
        return appointment.AddMinutes(-alertMinutesOffset);
    }

    public static bool HasDaylightSavingChanged(DateTime dt, Location location)
    {
        var timeZone = TimeZoneInfo.FindSystemTimeZoneById(variants[location].timezoneId);
        var now = dt;
        var oneWeekEarlier = now.AddDays(-7);
        bool dsBecomeActive = !timeZone.IsDaylightSavingTime(oneWeekEarlier) && timeZone.IsDaylightSavingTime(now);
        bool dsBecomeInactive = timeZone.IsDaylightSavingTime(oneWeekEarlier) && !timeZone.IsDaylightSavingTime(now);

        return dsBecomeActive || dsBecomeInactive;
    }

    public static DateTime NormalizeDateTime(string dtStr, Location location)
    {
        var culture = System.Globalization.CultureInfo.CreateSpecificCulture(variants[location].cultureName);
        DateTime normalisedDT;
        var parseResult = DateTime.TryParse(dtStr, culture, System.Globalization.DateTimeStyles.None, out normalisedDT);

        return parseResult ? normalisedDT : DateTime.MinValue;
    }
}
