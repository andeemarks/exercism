local School = {}
School.__index = School

function School:new()
    setmetatable({}, self)

    self._students = {}
    self._grades = {}

    return self
end

function School:roster()
    return self:_sort_students_by_grade()
end

function School:_sort_students_by_grade()
    students = {}
    for _, students_in_grade in pairs(self._grades) do 
        table.sort(students_in_grade)
        for _, student_name in pairs(students_in_grade) do 
            table.insert(students, student_name)
        end
    end

    return students
end

function School:is_new_student(name)
    for _, s in pairs(self._students) do
        if s == name then
            return false
        end
    end

    return true
end

function School:add(name, grade)
    if not self:is_new_student(name) then
        return false
    end

    local grade_students = self._grades[grade]
    if not grade_students then
        table.insert(self._students, name)

        self._grades[grade] = {name}
        return true
    end

    for _, s in pairs(grade_students) do
        if s == name then
            return false 
        end
    end

    table.insert(self._students, name)
    table.insert(grade_students, name)

    return true
end

function School:grade(grade)
    local students = self._grades[grade] or {}
    table.sort(students)

    return students
end

return School
