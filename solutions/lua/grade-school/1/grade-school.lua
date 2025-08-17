local School = {}

function School:new()
    setmetatable({}, self)
    self__index = {}

    self._students = {}
    self._grades = {}
    return self
end

function School:roster()
    roster = {}
    for _, s in pairs(self._grades) do 
        table.sort(s)
        for _, n in pairs(s) do 
            table.insert(roster, n)
        end
    end

    return roster
end

function is_new_student(students, name)
    for _, s in pairs(students) do
        if s == name then
            return false
        end
    end

    return true
end

function School:add(name, grade)
    if not is_new_student(self._students, name) then
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
