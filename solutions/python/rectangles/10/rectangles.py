CORNER = '+'

def rectangles(strings: list[str]) -> int:
    corners = _find_corners(strings)
    
    # Check all pairs of corners to see if they form rectangles
    rectangles = set()
    for i in range(len(corners)):
        for j in range(i + 1, len(corners)):
            r1, c1 = corners[i]
            r2, c2 = corners[j]
            
            if r1 == r2 or c1 == c2:
                continue
            
            top_left, bottom_right = _find_diagonal_corners(r1, c1, r2, c2)
            
            if _is_rectangle(strings, top_left, bottom_right):
                rect = (top_left, bottom_right)
                rectangles.add(rect)
    
    return len(rectangles)

def _find_diagonal_corners(r1: int, c1: int, r2: int, c2: int):
    top_left = (min(r1, r2), min(c1, c2))
    bottom_right = (max(r1, r2), max(c1, c2))

    return top_left, bottom_right

def _find_corners(strings: list[str]) -> list[(int, int)]:
    rows = len(strings)
    cols = len(strings[0]) if strings else 0
    
    corners = []
    for r in range(rows):
        for c in range(min(cols, len(strings[r]))):
            if strings[r][c] == CORNER:
                corners.append((r, c))

    return corners

def _is_rectangle(grid: list[str], top_left: list[int], bottom_right: list[int]) -> bool:
    r1, c1 = top_left
    r2, c2 = bottom_right
    
    if r2 >= len(grid) or c2 >= len(grid[0]):
        return False

    HORZ_SIZE_CHARS = [CORNER, '-']    
    VERT_SIZE_CHARS = [CORNER, '|']    

    for c in range(c1, c2 + 1):
        if grid[r1][c] not in HORZ_SIZE_CHARS:
            return False
        if grid[r2][c] not in HORZ_SIZE_CHARS:
            return False
    
    for r in range(r1, r2 + 1):
        if grid[r][c1] not in VERT_SIZE_CHARS:
            return False
        if grid[r][c2] not in VERT_SIZE_CHARS:
            return False
    
    return True
