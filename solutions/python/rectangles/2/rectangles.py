def rectangles(strings):
    rectangles = []
    rows = len(strings)
    cols = len(strings[0]) if strings else 0
    
    # Find all potential corner positions ('+' characters)
    corners = []
    for r in range(rows):
        for c in range(min(cols, len(strings[r]))):
            if strings[r][c] == '+':
                corners.append((r, c))
    
    # Check all pairs of corners to see if they form rectangles
    for i in range(len(corners)):
        for j in range(i + 1, len(corners)):
            r1, c1 = corners[i]
            r2, c2 = corners[j]
            
            # Skip if not forming a proper rectangle (need different rows and cols)
            if r1 == r2 or c1 == c2:
                continue
            
            # Ensure top-left and bottom-right ordering
            top_left = (min(r1, r2), min(c1, c2))
            bottom_right = (max(r1, r2), max(c1, c2))
            
            if is_valid_rectangle(strings, top_left, bottom_right):
                rect = (top_left, bottom_right)
                if rect not in rectangles:
                    rectangles.append(rect)
    
    return len(rectangles)

def is_valid_rectangle(grid, top_left, bottom_right):
    r1, c1 = top_left
    r2, c2 = bottom_right
    
    # Check if coordinates are within bounds
    if r2 >= len(grid) or c2 >= len(grid[0]):
        return False
    
    # Check all four corners are '+'
    corners_to_check = [(r1, c1), (r1, c2), (r2, c1), (r2, c2)]
    for r, c in corners_to_check:
        if r >= len(grid) or c >= len(grid[r]) or grid[r][c] != '+':
            return False
    
    # Check top and bottom edges (should be '+' or '-')
    for c in range(c1, c2 + 1):
        if c >= len(grid[r1]) or grid[r1][c] not in ['+', '-']:
            return False
        if c >= len(grid[r2]) or grid[r2][c] not in ['+', '-']:
            return False
    
    # Check left and right edges (should be '+' or '|')
    for r in range(r1, r2 + 1):
        if c1 >= len(grid[r]) or grid[r][c1] not in ['+', '|']:
            return False
        if c2 >= len(grid[r]) or grid[r][c2] not in ['+', '|']:
            return False
    
    return True
