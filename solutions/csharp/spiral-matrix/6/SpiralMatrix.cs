public class SpiralMatrix
{
    public static int[,] GetMatrix(int size)
    {
        if (size == 0)
        {
            return new int[0, 0];
        }

        var matrix = new int[size, size];
        int row = 0, col = 0;
        int value = 1;
        var direction = new DirectionVectors();

        for (int i = 0; i < size * size; i++)
        {
            matrix[row, col] = value++;

            var (nextRow, nextCol) = direction.NextPosition(row, col);

            // Check if we need to turn (out of bounds or cell already filled)
            var isOutOfBounds = nextRow < 0 || nextRow >= size || nextCol < 0 || nextCol >= size;
            var isTurnNeeded = isOutOfBounds || matrix[nextRow, nextCol] != 0;
            if (isTurnNeeded)
            {
                direction.TurnClockwise();
                (nextRow, nextCol) = direction.NextPosition(row, col);
            }

            row = nextRow;
            col = nextCol;
        }

        return matrix;
    }
}

public class DirectionVectors
{
    private readonly int[] _dRow = [0, 1, 0, -1];
    private readonly int[] _dCol = [1, 0, -1, 0];
    private int _currentDirection = 0;

    public int DeltaRow => _dRow[_currentDirection];
    public int DeltaCol => _dCol[_currentDirection];

    public void TurnClockwise() => _currentDirection = (_currentDirection + 1) % 4;

    public (int, int) NextPosition(int row, int col) => (row + DeltaRow, col + DeltaCol);
}
