from __future__ import annotations

class Node:
    def __init__(self, value, succeeding: Node = None, previous: Node = None):
        self.value = value
        self.succeeding = succeeding
        self.previous = previous
    
    def __repr__(self):
        prev_val = self.previous.value if self.previous else None
        next_val = self.succeeding.value if self.succeeding else None
        return f"{prev_val} <- {self.value} -> {next_val}"

class LinkedList:
    def __init__(self):
        self.root = None
        self.size = 0
    
    def push(self, n):
        new_node = Node(n)
        if self.root is None:
            self.root = new_node
        else:
            current = self.root
            while current.succeeding is not None:
                current = current.succeeding
            current.succeeding = new_node
            new_node.previous = current
        self.size += 1
    
    def pop(self):
        if self.root is None:
            raise IndexError("List is empty")
        
        current = self.root
        while current.succeeding is not None:
            current = current.succeeding
        
        value = current.value
        
        if current.previous is None:
            self.root = None
        else:
            current.previous.succeeding = None
        
        self.size -= 1

        return value
    
    def shift(self):
        if self.root is None:
            raise IndexError("List is empty")
        
        value = self.root.value
        self.root = self.root.succeeding
        
        if self.root is not None:
            self.root.previous = None
        
        self.size -= 1

        return value
    
    def unshift(self, n):
        new_node = Node(n)

        if self.root is not None:
            new_node.succeeding = self.root
            self.root.previous = new_node

        self.root = new_node
        self.size += 1
    
    def __len__(self):
        return self.size
    
    def delete(self, n):
        if self.root is None:
            raise ValueError("Value not found")
        
        current = self.root
        
        while current is not None and current.value != n:
            current = current.succeeding
        
        if current is None:
            raise ValueError("Value not found")
        
        if current.previous is None:
            self.root = current.succeeding
            if self.root is not None:
                self.root.previous = None
        else:
            current.previous.succeeding = current.succeeding
            if current.succeeding is not None:
                current.succeeding.previous = current.previous
        
        self.size -= 1
    