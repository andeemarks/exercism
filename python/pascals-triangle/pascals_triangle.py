def rows(row_count):
    if row_count < 0:
        raise ValueError("number of rows is negative")

    if row_count == 0:
        return []

    return build_rows([[1]], 1, row_count)


def build_rows(rows, current_row_index, final_row_index):
    if current_row_index >= final_row_index:
        return rows

    previous_row = rows[-1]
    new_row = []
    for i, left_number in enumerate(previous_row[0: -1]):
        right_number = previous_row[i + 1]
        new_row += [left_number + right_number]

    rows.append([1] + new_row + [1])

    return build_rows(rows, current_row_index + 1, final_row_index)
