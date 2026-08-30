def rectangles(strings):
    found_rectangles = find_rectangles_in(strings)
    new_strings = remove_inner_rectangle_horizontally(strings)
    found_rectangles.update(find_rectangles_in(new_strings))
    new_strings = remove_inner_rectangle_vertically(strings)
    found_rectangles.update(find_rectangles_in(new_strings))

    for i in range(0, 10):
        new_strings = remove_inner_rectangle_horizontally(new_strings)
        horizontal_rectangles = find_rectangles_in(new_strings)
        found_rectangles.update(horizontal_rectangles)
        new_strings = remove_inner_rectangle_vertically(new_strings)
        vertical_rectangles = find_rectangles_in(new_strings)
        # _print(new_strings)
        found_rectangles.update(vertical_rectangles)

    return len(found_rectangles)

def _print(strings):
    for line in strings:
        print(line)

def remove_inner_rectangle_horizontally(strings):
    return list(map(lambda line: line.replace("-+-", "---", 1), strings))

def remove_inner_rectangle_vertically(strings):
    new_strings = rotate_90_degrees(strings)
    new_strings = list(map(lambda line: line.replace("|+|", "|||", 1), new_strings))
    new_strings = rotate_90_degrees(new_strings)
    new_strings = rotate_90_degrees(new_strings)
    new_strings = rotate_90_degrees(new_strings)

    return new_strings

def rotate_90_degrees(array: list[str]) -> list[str]:
    return list(map(''.join, (zip(*array[::-1]))))

def find_rectangles_in(strings: list[str]) -> set[list[str]]:
    found_rectangles = set()
    for (line_nbr, line) in enumerate(strings):
        for (cell_nbr, cell) in enumerate(line):
            if cell == CORNER:
                try:
                    found_rectangles.add(describe_rectangle_at(strings, line_nbr, cell_nbr))
                except (ValueError, IndexError):
                    pass

    return found_rectangles

def describe_rectangle_at(strings, tl_line_nbr: int, tl_cell_nbr: int) -> tuple:
    coords = list()
    coords.append((tl_line_nbr, tl_cell_nbr))

    tr_cell_nbr = find_tr_cell(tl_cell_nbr, strings[tl_line_nbr])
    if tr_cell_nbr < 0:
        raise ValueError
    
    coords.append((tl_line_nbr, tr_cell_nbr))
    
    br_line_nbr = find_br_line(tl_line_nbr, tr_cell_nbr, strings)
    if br_line_nbr < 0:
        raise ValueError
    
    coords.append((br_line_nbr, tr_cell_nbr))

    bl_cell_nbr = find_bl_cell(tr_cell_nbr, tl_cell_nbr, strings[br_line_nbr])
    if bl_cell_nbr < 0:
        raise ValueError
    
    coords.append((br_line_nbr, tl_cell_nbr))

    is_completed = can_join_rh_side(br_line_nbr, tl_line_nbr, tl_cell_nbr, strings)

    if is_completed:
        print(f"rectangle at: {coords}")
        return tuple(coords)
    
    raise ValueError

CORNER = "+"
VERT_WALL_CHARS = [CORNER, "|"]
HORZ_WALL_CHARS = [CORNER, "-"]

def find_tr_cell(start_cell_nbr, line) -> int:
    cell_nbr = start_cell_nbr + 1
    try:
        cell = line[cell_nbr]
        while cell != CORNER:
            if cell not in HORZ_WALL_CHARS:
                return -1
            cell_nbr += 1    
            cell = line[cell_nbr]
            
        if cell != CORNER:
            return -1
    except IndexError:
        return -1
    
    return cell_nbr

def find_br_line(line_nbr, cell_nbr, strings) -> int:
    next_line_nbr = line_nbr + 1
    cell = strings[next_line_nbr][cell_nbr]        
    while cell != CORNER and cell == "|":
        next_line_nbr += 1
        cell = strings[next_line_nbr][cell_nbr]
        
    if cell != CORNER:
        return -1

    return next_line_nbr

def can_join_rh_side(start_line_nbr, end_line_nbr, cell_nbr, strings) -> bool:
    next_line_nbr = start_line_nbr - 1
    cell = strings[next_line_nbr][cell_nbr]        
    
    while next_line_nbr > end_line_nbr and cell in VERT_WALL_CHARS:
        next_line_nbr -= 1
        cell = strings[next_line_nbr][cell_nbr]

    if cell == "|" or next_line_nbr == end_line_nbr:
        return True

    return False

def find_bl_cell(start_cell_nbr, end_cell_nbr, line) -> int:
    actual_side = line[end_cell_nbr:start_cell_nbr]
    expected_side = CORNER + ((start_cell_nbr - end_cell_nbr - 1) * "-")
    print(actual_side)
    print(expected_side)
    if actual_side == expected_side:
        return end_cell_nbr
    else:
        return -1
    # cell_nbr = start_cell_nbr - 1
    # cell = line[cell_nbr]
    # while cell_nbr > end_cell_nbr and cell in HORZ_WALL_CHARS:
    #     cell_nbr -= 1
    #     cell = line[cell_nbr]

    # if cell_nbr == end_cell_nbr and cell == CORNER:
    #     return cell_nbr

    # return -1
