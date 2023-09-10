"""Functions which helps the locomotive engineer to keep track of the train."""


def get_list_of_wagons(*wagons):
    """Return a list of wagons.

    :param: arbitrary number of wagons.
    :return: list - list of wagons.
    """

    return [*wagons]


def fix_list_of_wagons(each_wagons_id, missing_wagons):
    """Fix the list of wagons.

    :parm each_wagons_id: list - the list of wagons.
    :parm missing_wagons: list - the list of missing wagons.
    :return: list - list of wagons.
    """

    wagon_1, wagon_2, locomotive, *remaining_wagons = each_wagons_id

    return [locomotive, *missing_wagons, *remaining_wagons, wagon_1, wagon_2]


def add_missing_stops(route, **stops):
    """Add missing stops to route dict.

    :param route: dict - the dict of routing information.
    :param: arbitrary number of stops.
    :return: dict - updated route dictionary.
    """

    return route | {'stops': list(stops.values())}


def extend_route_information(route, more_route_information):
    """Extend route information with more_route_information.

    :param route: dict - the route information.
    :param more_route_information: dict -  extra route information.
    :return: dict - extended route information.
    """

    return {**route, **more_route_information}


def fix_wagon_depot(wagons_rows):
    """Fix the list of rows of wagons.

    :param wagons_rows: list[list[tuple]] - the list of rows of wagons.
    :return: list[list[tuple]] - list of rows of wagons.
    """
    
    [
        [row_1_col_1, row_1_col_2, row_1_col_3], 
        [row_2_col_1, row_2_col_2, row_2_col_3],
        [row_3_col_1, row_3_col_2, row_3_col_3]] = wagons_rows

    return [
        [row_1_col_1, row_2_col_1, row_3_col_1],
        [row_1_col_2, row_2_col_2, row_3_col_2],
        [row_1_col_3, row_2_col_3, row_3_col_3],
        ]
