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

        var studentsInGrade = roster.GetValueOrDefault(grade, []);
        studentsInGrade.Add(student);
        studentsInGrade.Sort();
        roster[grade] = studentsInGrade;

        this.students.Add(student);

        return true;
    }

    public IEnumerable<string> Roster()
    {
        var sortedRoster = new List<string>();

        foreach (var grade in roster.Keys)
        {
            var students = roster[grade];
            students.Sort();
            sortedRoster.AddRange(students);
        }

        return sortedRoster;
    }

    public IEnumerable<string> Grade(int grade)
    {
        return roster.GetValueOrDefault(grade, []);
    }
}