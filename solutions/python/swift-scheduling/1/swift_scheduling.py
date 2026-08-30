import re
import calendar
from datetime import datetime, timedelta

def delivery_date(start, description):
    start_dt = datetime.strptime(start, "%Y-%m-%dT%H:%M:%S")
    match description:
        case "NOW":
            return _format(start_dt + timedelta(hours=2))
        case "ASAP":
            return _handle_asap_delivery(start_dt)
        case "EOW":
            return _handle_end_of_week_delivery(start_dt)
        
    if re.match(r"[0-9]+M", description):
        return _handle_n_month_description(start_dt, description)

    if re.match(r"Q[0-9]+", description):
        return _handle_n_quarter_description(start_dt, description)
    
def _handle_n_quarter_description(start_dt: datetime, description: str) -> str:
    current_quarter = start_dt.month // 3 + 1
    delivery_quarter = int(description.lstrip("Q"))

    if current_quarter <= delivery_quarter:
        last_workday = _last_workday_of_quarter(start_dt.year, delivery_quarter)
        delivery_dt = datetime(start_dt.year, delivery_quarter * 3, last_workday, 8, 0, 0)

        return _format(delivery_dt)
    else:
        last_workday = _last_workday_of_quarter(start_dt.year + 1, delivery_quarter)
        delivery_dt = datetime(start_dt.year + 1, delivery_quarter * 3, last_workday, 8, 0, 0)

        return _format(delivery_dt)

def _last_workday_of_quarter(year: int, quarter: int) -> int:
    _, last_day = calendar.monthrange(year, quarter * 3)
    current_day = datetime(year, quarter * 3, last_day)
    while (current_day.isoweekday() not in range(1,6)):
        current_day = current_day + timedelta(days=-1)

    return current_day.day

def _handle_n_month_description(start_dt: datetime, description: str) -> str:
    current_month = start_dt.month
    delivery_month = int(description.rstrip("M"))

    if current_month < delivery_month:
        first_workday = _first_workday_of_month_year(start_dt.year, delivery_month)
        delivery_dt = datetime(start_dt.year, delivery_month, first_workday, 8, 0, 0)

        return _format(delivery_dt)
    else:
        first_workday = _first_workday_of_month_year(start_dt.year + 1, delivery_month)
        delivery_dt = datetime(start_dt.year + 1, delivery_month, first_workday, 8, 0, 0)

        return _format(delivery_dt)

def _first_workday_of_month_year(year: int, month: int) -> int:
    current_day = datetime(year, month, 1)
    while (current_day.isoweekday() not in range(1,6)):
        current_day = current_day + timedelta(days=1)

    return current_day.day

def _handle_asap_delivery(start_dt: datetime) -> str:
    if (start_dt.hour < 13):
        delivery_dt = datetime(start_dt.year, start_dt.month, start_dt.day, 17, 0, 0)

        return _format(delivery_dt)
    else:
        delivery_dt = datetime(start_dt.year, start_dt.month, start_dt.day + 1, 13, 0, 0)

        return _format(delivery_dt)
        
def _handle_end_of_week_delivery(start_dt: datetime) -> str:
    weekday = datetime.strftime(start_dt, '%A')
    match weekday:
        case "Monday":
            friday_dt = start_dt + timedelta(days=4)
            delivery_dt = datetime(friday_dt.year, friday_dt.month, friday_dt.day, 17, 0, 0)
        case "Tuesday":
            friday_dt = start_dt + timedelta(days=3)
            delivery_dt = datetime(friday_dt.year, friday_dt.month, friday_dt.day, 17, 0, 0)
        case "Wednesday":
            friday_dt = start_dt + timedelta(days=2)
            delivery_dt = datetime(friday_dt.year, friday_dt.month, friday_dt.day, 17, 0, 0)
        case "Thursday":
            sunday_dt = start_dt + timedelta(days=3)
            delivery_dt = datetime(sunday_dt.year, sunday_dt.month, sunday_dt.day, 20, 0, 0)
        case "Friday":
            sunday_dt = start_dt + timedelta(days=2)
            delivery_dt = datetime(sunday_dt.year, sunday_dt.month, sunday_dt.day, 20, 0, 0)

    return _format(delivery_dt)

def _format(delivery_dt: datetime) -> str:
    return datetime.strftime(delivery_dt, "%Y-%m-%dT%H:%M:%S")