class Robot(initialPosition: GridPosition, initialOrientation: Orientation) {

    fun turnRight() {
        orientation = orientation.right
    }

    fun turnLeft() {
        orientation = orientation.left
    }

    fun advance() {
        gridPosition = GridPosition(gridPosition.x + orientation.xMoveIncrement, gridPosition.y + orientation.yMoveIncrement)
    }

    fun simulate(instructions: String) {
        instructions.map { instruction: Char ->
            when (instruction.toLowerCase()) {
                'a' -> advance()
                'l' -> turnLeft()
                'r' -> turnRight()
            }
        }
    }

    var gridPosition: GridPosition = initialPosition
    var orientation: Orientation = initialOrientation

}
