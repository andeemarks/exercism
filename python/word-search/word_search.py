class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y
    
    def __repr__(self):
        return f"{self.x},{self.y}"
    
    def reflect(self):
        return Point(self.y, self.x)

class CharPoint:
    def __init__(self, index, point, char):
        self.index = index
        self.point = point
        self.char = char

class WordSearch:
    def __init__(self, puzzle):
        self.rows = puzzle
        columns_chars = [list(x) for x in list(zip(*self.rows))]
        self.columns = ["".join(x) for x in columns_chars]
        row_length = len(self.rows[0])
        self.l2r_diagonals = self.build_l2r_diagonals(row_length)
        self.r2l_diagonals = self.build_r2l_diagonals(row_length)

    def build_l2r_diagonals(self, row_length):
        chars = [char for row in self.rows for char in row]
        indexed_chars = [CharPoint(i, Point(i % row_length , i // row_length), char) for i, char in enumerate(chars)]

        return self.build_diagonals_from(indexed_chars, row_length)

    def build_r2l_diagonals(self, row_length):
        chars = [char for row in self.rows for char in row[::-1]]
        indexed_chars = [CharPoint(i, Point(row_length - (i % row_length) - 1 , i // row_length), char) for i, char in enumerate(chars)]

        return self.build_diagonals_from(indexed_chars, row_length)

    def build_diagonals_from(self, indexed_chars, row_length):
        diagonals = []
        for offset in range(0, row_length):
            diagonal = list(filter(lambda char_point: (char_point.index + offset) % (row_length + 1) == 0, indexed_chars))
            diagonals.append(diagonal)

        return diagonals

    def search(self, word):
        try:
            return self.search_rows(self.rows, word)
        except ValueError:
            pass

        try:
            return self.search_columns(self.columns, word)
        except ValueError:
            pass

        try:
            return self.search_diagonals(self.l2r_diagonals, word)
        except ValueError:
            pass

        try:
            return self.search_diagonals(self.r2l_diagonals, word)
        except ValueError:
            return None

    def search_columns(self, columns, word):
        (word_start, word_end) = self.search_rows(columns, word)

        return word_start.reflect(), word_end.reflect()

    def search_diagonals(self, diagonals, word):
        for diagonal in diagonals:
            chars = "".join([char_point.char for char_point in diagonal])
            (word_start, word_end) = self.search_diagonal(diagonal, chars, word)

            if word_start:
                return (word_start, word_end)
            
            (word_start, word_end) = self.search_diagonal(diagonal, chars, word[::-1])

            if word_start:
                return (word_end, word_start)

        raise ValueError
    
    def search_diagonal(self, diagonal, chars, word):
        if word in chars:
            word_position = chars.index(word)
            first_char = diagonal[word_position]
            last_char = diagonal[word_position + len(word) - 1] 

            return first_char.point, last_char.point
        else:
            return None, None

    def search_rows(self, rows, word):
        for row, i in zip(rows, range(len(rows))):
            (word_start, word_end) = self.search_row(row, i, word[::1])

            if word_start:
                return (word_start, word_end)
            
            (word_start, word_end) = self.search_row(row, i, word[::-1])

            if word_start:
                return word_end, word_start

        raise ValueError
    
    def search_row(self, row, row_index, word):
        if word in row:
            word_position = row.index(word)

            return Point(word_position, row_index), Point(word_position + len(word) - 1, row_index)
        else:
            return None, None
