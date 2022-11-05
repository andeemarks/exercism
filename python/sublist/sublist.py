"""
This exercise stub and the test suite contain several enumerated constants.

Since Python 2 does not have the enum module, the idiomatic way to write
enumerated constants has traditionally been a NAME assigned to an arbitrary,
but unique value. An integer is traditionally used because it’s memory
efficient.
It is a common practice to export both constants and functions that work with
those constants (ex. the constants in the os, subprocess and re modules).

You can learn more here: https://en.wikipedia.org/wiki/Enumerated_type
"""

# Possible sublist categories.
# Change the values as you see fit.
SUBLIST = 0
SUPERLIST = 1
EQUAL = 2
UNEQUAL = 4


def deep_check(sub_list, super_list):
    """
    Make sure sublists are only found at the end of the super list,
    or immediately before the next item in the superlist.
    """
    sublist_pos = super_list.find(sub_list)
    sublist_len = len(sub_list)
    sublist_at_end = super_list.endswith(sub_list)
    sublist_before_comma = (
        super_list[sublist_pos + sublist_len] == ',') if not sublist_at_end else False

    return sublist_at_end | sublist_before_comma | (sublist_len == 0)


def sublist(list_one, list_two):
    """docstring"""

    if list_one == list_two:
        return EQUAL

    list_one_str = ",".join(list(map(str, list_one)))
    list_two_str = ",".join(list(map(str, list_two)))

    if list_one_str in list_two_str:
        if deep_check(list_one_str, list_two_str):
            return SUBLIST
    if list_two_str in list_one_str:
        if deep_check(list_two_str, list_one_str):
            return SUPERLIST

    return UNEQUAL
