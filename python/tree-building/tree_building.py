class Record:
    def __init__(self, record_id, parent_id):
        self.record_id = record_id
        self.parent_id = parent_id

    def validate(self):
        if self.record_id < self.parent_id:
            raise ValueError("Node parent_id should be smaller than it's record_id.")
        if self.record_id == self.parent_id and self.record_id != 0:
            raise ValueError("Only root should have equal record and parent id.")

class Node:
    def __init__(self, record):
        self.node_id = record.record_id
        self.children = []

    def add_child(self, child):
        self.children.append(child)

def BuildTree(records):
    records.sort(key=lambda x: x.record_id)
    if records:
        validate_records(records)

    trees = build_tree_nodes(records)
    assign_parents(records, trees)

    return trees[0] if len(trees) > 0 else None

def build_tree_nodes(records):
    return [Node(record) for record in records]

def assign_parent(tree, record, parent):
    if tree.node_id > 0 and record.record_id == tree.node_id:
        parent.add_child(tree)

def huh(j, trees, parent, record):
    if j.parent_id == record.record_id:
        for tree in trees:
            assign_parent(tree, j, parent)

def assign_parents(records, trees):
    parent = {}
    for record in records:
        parent = find_parent(record, trees)
        for j in records:
            huh(j, trees, parent, record)

def find_parent(record, trees):
    return next(tree_node for tree_node in trees if record.record_id == tree_node.node_id)

def validate_records(records):
    if records[-1].record_id != len(records) - 1:
        raise ValueError("Record id is invalid or out of order.") if records[-1].record_id != len(records) - 1 else None
    if records[0].record_id != 0:
        raise ValueError('invalid')
    [record.validate() for record in records]
