using System;

static class Badge
{
    public static string Print(int? id, string name, string? department)
    {
        string departmentName = (department ?? "owner").ToUpper();
        
        if (id == null)
        {
            return $"{name} - {(department ?? "owner").ToUpper()}";
        }

        return $"[{id}] - {name} - {(department ?? "owner").ToUpper()}";

    }
}
