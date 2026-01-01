public static class Dominoes
{
    // Domain: Domino Chain Validation
    
    public static bool CanChain(IEnumerable<(int, int)> dominoes)
    {
        var list = dominoes.ToList();
        
        if (list.Count == 0)
            return true;
        
        if (list.Count == 1)
            return list[0].Item1 == list[0].Item2;
        
        var graph = new Graph(list);
        return graph.IsConnected() && graph.AllDegreesEven();
    }
}

// Graph Theory: Eulerian Circuit Validation

file class Graph
{
    private readonly Dictionary<int, int> degrees = [];
    private readonly HashSet<int> nodes = [];
    private readonly List<(int, int)> dominoes;
    
    public Graph(List<(int, int)> dominoes)
    {
        this.dominoes = dominoes;
        this.degrees = BuildDegrees();
    }
    
    public bool IsConnected()
    {
        if (nodes.Count == 0)
            return true;
        
        var visited = new GraphTraversal(BuildAdjacencyList()).Visit(nodes.First());
        return visited.Count == nodes.Count;
    }

    public bool AllDegreesEven() => degrees.Values.All(d => d % 2 == 0);

    private Dictionary<int, int> BuildDegrees()
    {
        var degrees = new Dictionary<int, int>();

        foreach (var (a, b) in dominoes)
        {
            nodes.Add(a);
            nodes.Add(b);
            
            if (a == b)
            {
                // Self-loop counts as degree 2
                degrees[a] = degrees.GetValueOrDefault(a, 0) + 2;
            }
            else
            {
                degrees[a] = degrees.GetValueOrDefault(a, 0) + 1;
                degrees[b] = degrees.GetValueOrDefault(b, 0) + 1;
            }
        }
        return degrees;
    }
    
    private Dictionary<int, HashSet<int>> BuildAdjacencyList()
    {
        var adj = new Dictionary<int, HashSet<int>>();
        foreach (var node in nodes)
            adj[node] = [];
        
        foreach (var (a, b) in dominoes)
        {
            adj[a].Add(b);
            if (a != b)
                adj[b].Add(a);
        }
        
        return adj;
    }
    
    private class GraphTraversal
    {
        private readonly Dictionary<int, HashSet<int>> adjacency;
        
        public GraphTraversal(Dictionary<int, HashSet<int>> adjacency)
        {
            this.adjacency = adjacency;
        }
        
        public HashSet<int> Visit(int startNode)
        {
            var visited = new HashSet<int>();
            DepthFirstSearch(startNode, visited);
            return visited;
        }
        
        private void DepthFirstSearch(int node, HashSet<int> visited)
        {
            visited.Add(node);
            foreach (var neighbor in adjacency[node])
                if (!visited.Contains(neighbor))
                    DepthFirstSearch(neighbor, visited);
        }
    }
}