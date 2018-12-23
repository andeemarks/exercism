enum class Orientation {

    NORTH {
        override val xMoveIncrement: Int
            get() = 0
        override val yMoveIncrement: Int
            get() = 1
        override val left: Orientation
            get() = WEST
        override val right: Orientation
            get() = EAST
    }, EAST {
        override val xMoveIncrement: Int
            get() = 1
        override val yMoveIncrement: Int
            get() = 0
        override val left: Orientation
            get() = NORTH
        override val right: Orientation
            get() = SOUTH
    }, SOUTH {
        override val xMoveIncrement: Int
            get() = 0
        override val yMoveIncrement: Int
            get() = -1
        override val left: Orientation
            get() = EAST
        override val right: Orientation
            get() = WEST
    }, WEST {
        override val xMoveIncrement: Int
            get() = -1
        override val yMoveIncrement: Int
            get() = 0
        override val right: Orientation
            get() = NORTH
        override val left: Orientation
            get() = SOUTH
    };

    abstract val left: Orientation
    abstract val right: Orientation
    abstract val xMoveIncrement: Int
    abstract val yMoveIncrement: Int

}
