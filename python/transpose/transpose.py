def transpose(lines):
    if lines == "":
        return lines

    rows = lines.splitlines()
    longest_row = max(map(lambda row: len(row), rows))

    transposed_rows = [""] * longest_row
    for row_index, row in enumerate(rows):
        row = row.ljust(longest_row, ' ')
        # print(f"row: |{row}|")
        for col_index, cell in enumerate(list(row)):
            transposed_rows[col_index] += cell
            # print(transposed_rows)

    transposed_rows[-1] = transposed_rows[-1].rstrip()

    print(f"{transposed_rows}")

    return "\n".join(transposed_rows)
