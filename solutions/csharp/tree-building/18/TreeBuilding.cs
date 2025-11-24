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

        return !tree.IsValid(previousRecordId) ? throw new ArgumentException() : tree;
    }

}

public class TreeHolder(List<Tree> nodes)
{
    public List<Tree> Nodes { get; set; } = nodes;

    internal static TreeHolder FromNodes(List<Tree> nodes)
    {
        return nodes.Count == 0 ? throw new ArgumentException() : new TreeHolder(nodes);
    }
}

public static class TreeBuilder
{
    public static Tree BuildTree(IEnumerable<TreeBuildingRecord> records)
    {
        var sortedRecords = SortRecords(records);

        var tree = BuildNodes(sortedRecords);

        AssignChildTrees(tree);

        return tree.Nodes.First(t => t.Id == 0);
    }

    private static void AssignChildTrees(TreeHolder tree)
    {
        for (int i = 1; i < tree.Nodes.Count; i++)
        {
            var t = tree.Nodes.First(x => x.Id == i);
            var parent = tree.Nodes.First(x => x.Id == t.ParentId);
            parent.Children.Add(t);
        }
    }

    private static TreeHolder BuildNodes(IEnumerable<TreeBuildingRecord> sortedRecords)
    {
        var previousRecordId = -1;
        var nodes = sortedRecords.Select(r => Tree.FromRecord(r, previousRecordId++)).ToList();

        return TreeHolder.FromNodes(nodes);
    }

    private static IEnumerable<TreeBuildingRecord> SortRecords(IEnumerable<TreeBuildingRecord> records) => records.OrderBy(r => r.RecordId);
}