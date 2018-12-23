import Orientation.*
import org.junit.Test
import kotlin.test.assertEquals

class RobotTest {

    @Test
    fun testRobotIsCreatedWithCorrectPositionAndOrientationByDefault() {
        val robot = Robot(GridPosition(x = 0, y = 0), NORTH)

        assertEquals(GridPosition(x = 0, y = 0), robot.gridPosition)
        assertEquals(NORTH, robot.orientation)
    }

        @Test
    fun testRobotCanBeCreatedWithCustomPositionAndOrientation() {
        val robot = Robot(GridPosition(x = -1, y = -1), SOUTH)

        assertEquals(GridPosition(x = -1, y = -1), robot.gridPosition)
        assertEquals(SOUTH, robot.orientation)
    }

        @Test
    fun testTurningRightCorrectlyChangesOrientationFromNorthToEast() {
        val robot = Robot(GridPosition(x = 0, y = 0), NORTH)

        robot.turnRight()

        assertEquals(EAST, robot.orientation)
    }

        @Test
    fun testTurningRightCorrectlyChangesOrientationFromEastToSouth() {
        val robot = Robot(GridPosition(x = 0, y = 0), EAST)

        robot.turnRight()

        assertEquals(SOUTH, robot.orientation)
    }

        @Test
    fun testTurningRightCorrectlyChangesOrientationFromSouthToWest() {
        val robot = Robot(GridPosition(x = 0, y = 0), SOUTH)

        robot.turnRight()

        assertEquals(WEST, robot.orientation)
    }

        @Test
    fun testTurningRightCorrectlyChangesOrientationFromWestToNorth() {
        val robot = Robot(GridPosition(x = 0, y = 0), WEST)

        robot.turnRight()

        assertEquals(NORTH, robot.orientation)
    }

        @Test
    fun testTurningLeftCorrectlyChangesOrientationFromNorthToWest() {
        val robot = Robot(GridPosition(x = 0, y = 0), NORTH)

        robot.turnLeft()

        assertEquals(WEST, robot.orientation)
    }

        @Test
    fun testTurningLeftCorrectlyChangesOrientationFromWestToSouth() {
        val robot = Robot(GridPosition(x = 0, y = 0), WEST)

        robot.turnLeft()

        assertEquals(SOUTH, robot.orientation)
    }

        @Test
    fun testTurningLeftCorrectlyChangesOrientationFromSouthToEast() {
        val robot = Robot(GridPosition(x = 0, y = 0), SOUTH)

        robot.turnLeft()

        assertEquals(EAST, robot.orientation)
    }

        @Test
    fun testTurningLeftCorrectlyChangesOrientationFromEastToNorth() {
        val robot = Robot(GridPosition(x = 0, y = 0), EAST)

        robot.turnLeft()

        assertEquals(NORTH, robot.orientation)
    }

        @Test
    fun testAdvancingDoesNotChangeOrientation() {
        val initialOrientation = NORTH
        val robot = Robot(GridPosition(x = 0, y = 0), initialOrientation)

        robot.advance()

        assertEquals(initialOrientation, robot.orientation)
    }

        @Test
    fun testAdvancingWhenFacingNorthIncreasesYCoordinateByOne() {
        val robot = Robot(GridPosition(x = 0, y = 0), NORTH)

        robot.advance()

        assertEquals(GridPosition(x = 0, y = 1), robot.gridPosition)
    }

        @Test
    fun testAdvancingWhenFacingSouthDecreasesYCoordinateByOne() {
        val robot = Robot(GridPosition(x = 0, y = 0), SOUTH)

        robot.advance()

        assertEquals(GridPosition(x = 0, y = -1), robot.gridPosition)
    }

        @Test
    fun testAdvancingWhenFacingEastIncreasesXCoordinateByOne() {
        val robot = Robot(GridPosition(x = 0, y = 0), EAST)

        robot.advance()

        assertEquals(GridPosition(x = 1, y = 0), robot.gridPosition)
    }

        @Test
    fun testAdvancingWhenFacingWestDecreasesXCoordinateByOne() {
        val robot = Robot(GridPosition(x = 0, y = 0), WEST)

        robot.advance()

        assertEquals(GridPosition(x = -1, y = 0), robot.gridPosition)
    }

        @Test
    fun testInstructionsToMoveEastAndNorthFromNorth() {
        val robot = Robot(GridPosition(x = 7, y = 3), NORTH)

        robot.simulate("RAALAL")

        assertEquals(GridPosition(x = 9, y = 4), robot.gridPosition)
        assertEquals(WEST, robot.orientation)
    }

        @Test
    fun testInstructionsToMoveWestAndNorth() {
        val robot = Robot(GridPosition(x = 0, y = 0), NORTH)

        robot.simulate("LAAARALA")

        assertEquals(GridPosition(x = -4, y = 1), robot.gridPosition)
        assertEquals(WEST, robot.orientation)
    }

        @Test
    fun testInstructionsToMoveWestAndSouth() {
        val robot = Robot(GridPosition(x = 2, y = -7), EAST)

        robot.simulate("RRAAAAALA")

        assertEquals(GridPosition(x = -3, y = -8), robot.gridPosition)
        assertEquals(SOUTH, robot.orientation)
    }

        @Test
    fun testInstructionsToMoveEastAndNorthFromSouth() {
        val robot = Robot(GridPosition(x = 8, y = 4), SOUTH)

        robot.simulate("LAAARRRALLLL")

        assertEquals(GridPosition(x = 11, y = 5), robot.gridPosition)
        assertEquals(NORTH, robot.orientation)
    }
}
