"""Functions to automate Conda airlines ticketing system."""


def generate_seat_letters(number):
    """Generate a series of letters for airline seats.

    :param number: int - total number of seat letters to be generated.
    :return: generator - generator that yields seat letters.

    Seat letters are generated from A to D.
    After D it should start again with A.

    Example: A, B, C, D

    """

    SEAT_LETTERS = ["A", "B", "C", "D"]

    for seat in range(number):
        yield SEAT_LETTERS[seat % len(SEAT_LETTERS)]


def generate_seats(number):
    """Generate a series of identifiers for airline seats.

    :param number: int - total number of seats to be generated.
    :return: generator - generator that yields seat numbers.

    A seat number consists of the row number and the seat letter.

    There is no row 13.
    Each row has 4 seats.

    Seats should be sorted from low to high.

    Example: 3C, 3D, 4A, 4B

    """

    rows = rows_for_seats(number)
    remaining_seats = number
    for row in rows:
        seats_for_row = 4 if remaining_seats >= 4 else remaining_seats
        for letter in generate_seat_letters(seats_for_row):
            yield f"{row}{letter}"
        remaining_seats -= seats_for_row


def rows_for_seats(number):
    raw_rows = list(range(1, max_row(number)))

    return remove_row(raw_rows, 13)


def max_row(number):
    max_row = (number // 4) + (number % 4) if number > 4 else number
    max_row += 1 if max_row >= 13 else 0

    return max_row + 1


def remove_row(raw_rows, row_number):
    rows = set(raw_rows)
    try:
        rows.remove(row_number)
    except KeyError:
        pass

    return rows


def assign_seats(passengers):
    """Assign seats to passengers.

    :param passengers: list[str] - a list of strings containing names of passengers.
    :return: dict - with the names of the passengers as keys and seat numbers as values.

    Example output: {"Adele": "1A", "Björk": "1B"}

    """

    seats = generate_seats(len(passengers))
    assigned_seats = {}
    for passenger in passengers:
        assigned_seats[passenger] = next(seats)

    return assigned_seats


def generate_codes(seat_numbers, flight_id):
    """Generate codes for a ticket.

    :param seat_numbers: list[str] - list of seat numbers.
    :param flight_id: str - string containing the flight identifier.
    :return: generator - generator that yields 12 character long ticket codes.

    """

    for seat in seat_numbers:
        yield f"{seat}{flight_id}".ljust(12, "0")
