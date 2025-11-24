public class TreeBuildingRecord
{
    public int ParentId { get; set; }
    public int RecordId { get; set; }
}

public class TreeNode
{
    public int Id { get; set; }
    public int ParentId { get; set; }

    public required List<TreeNode>  Children { get; set; }

    public bool IsLeaf => Children.Count == 0;

    public bool IsValid(int previousRecordId) => !(Id == 0 && ParentId != 0) && !(Id != 0 && ParentId >= Id) && !(Id != 0 && Id != previousRecordId + 1);

    public static TreeNode FromRecord(TreeBuildingRecord record, int previousRecordId)
    {
        TreeNode tree = new TreeNode { Children = [], Id = record.RecordId, ParentId = record.ParentId };

        if (!tree.IsValid(previousRecordId))
        {
            throw new ArgumentException();
        }

        return tree;
    }

}

public class Tree(List<TreeNode> nodes)
{
    public List<TreeNode> Nodes { get; set; } = nodes;

    internal static Tree FromNodes(List<TreeNode> nodes)
    {
        if (nodes.Count == 0)
        {
            throw new ArgumentException();
        }

        return new Tree(nodes);
    }
}

public static class TreeBuilder
{
    public static TreeNode BuildTree(IEnumerable<TreeBuildingRecord> records)
    {
        var sortedRecords = SortRecords(records);

        var tree = BuildNodes(sortedRecords);

        AssignChildTrees(tree);

        return tree.Nodes.First(t => t.Id == 0);
    }

    private static void AssignChildTrees(Tree tree)
    {
        for (int i = 1; i < tree.Nodes.Count; i++)
        {
            var t = tree.Nodes.First(x => x.Id == i);
            var parent = tree.Nodes.First(x => x.Id == t.ParentId);
            parent.Children.Add(t);
        }
    }

    private static Tree BuildNodes(IEnumerable<TreeBuildingRecord> sortedRecords)
    {
        var previousRecordId = -1;
        var nodes = sortedRecords.Select(r => TreeNode.FromRecord(r, previousRecordId++)).ToList();

        return Tree.FromNodes(nodes);
    }

    private static IEnumerable<TreeBuildingRecord> SortRecords(IEnumerable<TreeBuildingRecord> records) => records.OrderBy(r => r.RecordId);
}