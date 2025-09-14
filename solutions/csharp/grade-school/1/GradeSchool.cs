public class GradeSchool
{
    private readonly SortedDictionary<int, List<string>> roster;
    private readonly List<string> students;

    public GradeSchool()
    {
        this.roster = [];
        this.students = [];
    }

    public bool Add(string student, int grade)
    {
        if (this.students.Contains(student))
        {
            return false;
        }

        if (roster.ContainsKey(grade))
        {
            var studentsInGrade = this.roster[grade];
            studentsInGrade.Add(student);
            roster[grade] = studentsInGrade;
        }
        else
        {
            var studentsInGrade = new List<string>
            {
                student
            };
            roster.Add(grade, studentsInGrade);

        }

        this.students.Add(student);

        return true;
    }

    public IEnumerable<string> Roster()
    {
        var grades = this.roster.Keys;
        var sortedRoster = new List<string>();

        foreach (var grade in grades)
        {
            var students = this.roster[grade];
            students.Sort();
            sortedRoster.AddRange(students);
        }

        return sortedRoster;
    }

    public IEnumerable<string> Grade(int grade)
    {
        var studentsInGrade = this.roster.GetValueOrDefault(grade, []);
        studentsInGrade.Sort();
        
        return studentsInGrade;
    }
}