from __future__ import annotations

class Node:
    def __init__(self, value, next: Node = None, previous: Node = None):
        self.value = value
        self.next = next
        self.previous = previous

class LinkedList:
    def __init__(self):
        self.root = None
    
    def push(self, n):
        new_node = Node(n)
        if self.root is None:
            self.root = new_node
        else:
            current = self.root
            while current.next is not None:
                current = current.next
            current.next = new_node
            new_node.previous = current
    
    def pop(self):
        if self.root is None:
            raise IndexError("List is empty")
        
        current = self.root
        while current.next is not None:
            current = current.next
        
        value = current.value
        
        if current.previous is None:
            self.root = None
        else:
            current.previous.next = None
        
        return value
    
    def shift(self):
        if self.root is None:
            raise IndexError("List is empty")
        
        value = self.root.value
        self.root = self.root.next
        
        if self.root is not None:
            self.root.previous = None
        
        return value
    
    def unshift(self, n):
        new_node = Node(n)

        if self.root is not None:
            new_node.next = self.root
            self.root.previous = new_node

        self.root = new_node
    
    def __len__(self):

        if self.root == None:
            return 0
        
        size = 1
        current = self.root
        while current.next != None:
            current = current.next
            size += 1

        return size
    
    def delete(self, n):
        if self.root is None:
            raise ValueError("Value not found")
        
        current = self.root
        
        while current is not None and current.value != n:
            current = current.next
        
        if current is None:
            raise ValueError("Value not found")
        
        if current.previous is None:
            self.root = current.next
            if self.root is not None:
                self.root.previous = None
        else:
            current.previous.next = current.next
            if current.next is not None:
                current.next.previous = current.previous
    