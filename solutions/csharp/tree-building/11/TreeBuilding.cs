public class TreeBuildingRecord
{
    public int ParentId { get; set; }
    public int RecordId { get; set; }
}

public class Tree
{
    public int Id { get; set; }
    public int ParentId { get; set; }

    public required List<Tree>  Children { get; set; }

    public bool IsLeaf => Children.Count == 0;

    public bool IsValid(int previousRecordId) => !(Id == 0 && ParentId != 0) && !(Id != 0 && ParentId >= Id) && !(Id != 0 && Id != previousRecordId + 1);

    public static Tree FromRecord(TreeBuildingRecord record, int previousRecordId)
    {
        Tree tree = new Tree { Children = [], Id = record.RecordId, ParentId = record.ParentId };

        if (!tree.IsValid(previousRecordId))
        {
            throw new ArgumentException();
        }

        return tree;
    }

}

public static class TreeBuilder
{
    public static Tree BuildTree(IEnumerable<TreeBuildingRecord> records)
    {
        var sortedRecords = SortRecords(records);

        var trees = AddRecordsToTrees(sortedRecords);

        if (trees.Count == 0)
        {
            throw new ArgumentException();
        }

        AssignChildTrees(trees);

        return trees.First(t => t.Id == 0);
    }

    private static void AssignChildTrees(List<Tree> trees)
    {
        for (int i = 1; i < trees.Count; i++)
        {
            var t = trees.First(x => x.Id == i);
            var parent = trees.First(x => x.Id == t.ParentId);
            parent.Children.Add(t);
        }
    }

    private static List<Tree> AddRecordsToTrees(IEnumerable<TreeBuildingRecord> sortedRecords)
    {
        var trees = new List<Tree>();
        var previousRecordId = -1;

        return [.. sortedRecords.Select(r => Tree.FromRecord(r, previousRecordId++))];

    }

    private static IEnumerable<TreeBuildingRecord> SortRecords(IEnumerable<TreeBuildingRecord> records)
    {
        var ordered = new SortedList<int, TreeBuildingRecord>();

        foreach (var record in records)
        {
            ordered.Add(record.RecordId, record);
        }

        return ordered.Values;
    }
}