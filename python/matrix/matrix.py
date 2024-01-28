class Matrix:
    def __init__(self, matrix_string):
        self.rows = matrix_string.splitlines()

    def row(self, index):
        return [int(i) for i in self.rows[index - 1].split()]

    def column(self, index):
        return [self.row(r)[index - 1] for r in range(1, len(self.rows) + 1)]
