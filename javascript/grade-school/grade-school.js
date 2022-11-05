//
// This is only a SKELETON file for the 'Grade School' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class GradeSchool {
  db = {};

  clone = (db) => {
    return JSON.parse(JSON.stringify(db));
  };

  roster() {
    return this.clone(this.db);
  }

  gradeHasStudent(grade, name) {
    return (grade || []).includes(name);
  }

  findStudentGrade = (name) => {
    let allGrades = Object.keys(this.db);
    let gradesWithStudent = allGrades.filter((grade) => {
      return this.gradeHasStudent(this.db[grade], name);
    });

    return gradesWithStudent[0] || null;
  };

  removeStudentFromGrade = (name, grade) => {
    let studentsInGrade = this.db[grade] || [];
    let remainingStudents = studentsInGrade.filter((student) => {
      return student != name;
    });
    this.db[grade] = remainingStudents;
  };

  add(name, grade) {
    let currentStudentGrade = this.findStudentGrade(name);
    if (currentStudentGrade) {
      this.removeStudentFromGrade(name, currentStudentGrade);
    }

    let studentsInGrade = this.db[grade] || [];
    studentsInGrade.push(name);
    this.db[grade] = studentsInGrade.sort();
  }

  grade(grade) {
    return this.clone((this.db[grade] || []).sort());
  }
}
