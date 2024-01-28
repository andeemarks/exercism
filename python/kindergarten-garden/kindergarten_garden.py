
class Garden:
    def __init__(self, diagram, students=["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]):
        self.row1, self.row2 = diagram.split()
        self.students = students
        self.students.sort()

    def plants(self, student):
        student_position = self.students.index(student) * 2

        plant1, plant2 = self.lookup_plants_in_row(self.row1, student_position)
        plant3, plant4 = self.lookup_plants_in_row(self.row2, student_position)

        return [plant1, plant2, plant3, plant4]
    
    def lookup_plants_in_row(self, row, column):
        plant_abbreviations = {"R": "Radishes", "C": "Clover", "G": "Grass", "V": "Violets"}

        return plant_abbreviations[row[column: column + 1]], plant_abbreviations[row[column + 1: column + 2]]