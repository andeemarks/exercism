def find(search_list, value):
    return find_at_position(search_list, value, 0, len(search_list))


def find_at_position(search_list, value, start_pos, end_pos):
    if start_pos >= end_pos:
        raise ValueError("value not in array")

    position = start_pos + ((end_pos - start_pos) // 2)
    if search_list[position] == value:
        return position

    if (position == start_pos):
        raise ValueError("value not in array")

    if search_list[position] > value:
        return find_at_position(search_list, value, start_pos, position)
    else:
        return find_at_position(search_list, value, position, end_pos)
