import re
import calendar
from datetime import datetime, timedelta

FORMAT="%Y-%m-%dT%H:%M:%S"
WORKING_DAYS=range(1,6)

def delivery_date(start, description):
    start_dt = datetime.strptime(start, FORMAT)
    if description == "NOW":
        delivery_dt = start_dt + timedelta(hours=2)
    
    if description == "ASAP":
        delivery_dt = _handle_asap_delivery(start_dt)
    
    if description == "EOW":
        delivery_dt = _handle_end_of_week_delivery(start_dt)
        
    if re.match(r"[0-9]+M", description):
        delivery_dt = _handle_n_month_description(start_dt, int(description.rstrip("M")))

    if re.match(r"Q[1234]", description):
        delivery_dt = _handle_n_quarter_description(start_dt, int(description.lstrip("Q")))

    return datetime.strftime(delivery_dt, FORMAT)
    
def _handle_n_quarter_description(start_dt: datetime, quarter: int) -> datetime:
    current_quarter = start_dt.month // 3 + 1

    if current_quarter <= quarter:
        year = start_dt.year
    else:
        year = start_dt.year + 1

    last_workday = _last_workday_of_quarter(year, quarter)

    return datetime(year, quarter * 3, last_workday, 8, 0, 0)

def _last_workday_of_quarter(year: int, quarter: int) -> int:
    _, last_day = calendar.monthrange(year, quarter * 3)
    current_day = datetime(year, quarter * 3, last_day)
    while (current_day.isoweekday() not in WORKING_DAYS):
        current_day = current_day + timedelta(days=-1)

    return current_day.day

def _handle_n_month_description(start_dt: datetime, month: str) -> datetime:
    current_month = start_dt.month

    if current_month < month:
        year = start_dt.year
    else:
        year = start_dt.year + 1

    first_workday = _first_workday_of_month_year(year, month)

    return datetime(year, month, first_workday, 8, 0, 0)

def _first_workday_of_month_year(year: int, month: int) -> datetime:
    current_day = datetime(year, month, 1)
    while (current_day.isoweekday() not in WORKING_DAYS):
        current_day = current_day + timedelta(days=1)

    return current_day.day

def _handle_asap_delivery(start_dt: datetime) -> str:
    if (start_dt.hour < 13):
        day = start_dt.day
        hour = 17
    else:
        day = start_dt.day + 1
        hour = 13

    return datetime(start_dt.year, start_dt.month, day, hour, 0, 0)

def _handle_end_of_week_delivery(start_dt: datetime) -> datetime:
    eow_delivery_attributes = {"Monday": {"day_offset": 4, "hour": 17},
                               "Tuesday": {"day_offset": 3, "hour": 17},
                               "Wednesday": {"day_offset": 2, "hour": 17},
                               "Thursday": {"day_offset": 3, "hour": 20},
                               "Friday": {"day_offset": 2, "hour": 20},
                               }

    weekday = datetime.strftime(start_dt, '%A')
    attributes = eow_delivery_attributes[weekday]
    delivery_day_dt = start_dt + timedelta(attributes["day_offset"])

    return datetime(delivery_day_dt.year, delivery_day_dt.month, delivery_day_dt.day, attributes["hour"])