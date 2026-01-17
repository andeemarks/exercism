public class Queen
{
    public Queen(int row, int column)
    {
        Row = row;
        Column = column;
    }

    public int Row { get; }
    public int Column { get; }
}

public static class QueenAttack
{
    public static bool CanAttack(Queen white, Queen black)
    {
        var sameRow = white.Row == black.Row;
        var sameColumn = white.Column == black.Column;
        var sameDiagonal = Math.Abs(white.Row - black.Row) == Math.Abs(white.Column - black.Column);
        
        return sameRow || sameColumn || sameDiagonal;
    }

    public static Queen Create(int row, int column)
    {
        ValidatePosition(row, column);

        return new Queen(row, column);
    }

    private static void ValidatePosition(int row, int column)
    {
        if (row < 0 || row > 7)
            throw new ArgumentOutOfRangeException();
        if (column < 0 || column > 7)
            throw new ArgumentOutOfRangeException();
    }
}