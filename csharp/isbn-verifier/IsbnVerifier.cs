using System;

public static class IsbnVerifier
{
    public static bool IsValid(string number)
    {
        char[] isbn = number.Trim().Replace("-", "").ToCharArray();

        if (!isbn.IsValidIsbn())
        {
            return false;
        }

        int sum = isbn.GetCheckDigitValue();
        int isbnLength = isbn.GetLength(0);
        for (int i = 0; i < isbnLength - 1; i++)
        {
            sum += (isbnLength - i) * ValueOf(isbn[i]);
        }

        return sum % 11 == 0;
    }

    private static int ValueOf(char digit)
    {
        return (int)Char.GetNumericValue(digit);
    }

    private static bool IsValidIsbn(this char[] isbn)
    {
        int isbnLength = isbn.GetLength(0);
        if (isbnLength != 10)
        {
            return false;
        }

        char checkDigit = isbn[isbnLength - 1];
        if (!Char.IsDigit(checkDigit) && checkDigit != 'X')
        {
            return false;
        }

        ArraySegment<char> nonCheckDigits = new ArraySegment<char>(isbn, 0, isbnLength - 1);
        return Array.TrueForAll(nonCheckDigits.ToArray(), IsDigit);
    }

    private static bool IsDigit(char value) => Char.IsDigit(value);

    private static int GetCheckDigitValue(this char[] isbn)
    {
        char checkDigit = isbn[isbn.GetLength(0) - 1];

        return (checkDigit == 'X' ? 10 : ValueOf(checkDigit));
    }
}