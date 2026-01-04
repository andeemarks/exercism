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

        // Direction vectors: right, down, left, up
        int[] dRow = [0, 1, 0, -1];
        int[] dCol = [1, 0, -1, 0];
        int direction = 0;

        for (int i = 0; i < size * size; i++)
        {
            matrix[row, col] = value++;

            // Calculate next position
            int nextRow = row + dRow[direction];
            int nextCol = col + dCol[direction];

            // Check if we need to turn (out of bounds or cell already filled)
            if (nextRow < 0 || nextRow >= size || nextCol < 0 || nextCol >= size || matrix[nextRow, nextCol] != 0)
            {
                // Turn clockwise
                direction = (direction + 1) % 4;
                nextRow = row + dRow[direction];
                nextCol = col + dCol[direction];
            }

            row = nextRow;
            col = nextCol;
        }

        return matrix;
    }
}
