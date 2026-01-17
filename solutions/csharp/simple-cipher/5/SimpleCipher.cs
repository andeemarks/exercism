using System.Text;

public class SimpleCipher
{
    private string _key;

    public SimpleCipher() => _key = RandomLowercaseString(100);

    public SimpleCipher(string key) => _key = key;

    public string Key => _key;

    private static string RandomLowercaseString(int length)
    {
        const string alphabet = "abcdefghijklmnopqrstuvwxyz";

        return new string([.. Enumerable.Repeat(alphabet, length).Select(s => s[Random.Shared.Next(s.Length)])]);
    }

    public string Encode(string plaintext)
    {
        EnsureKeyLength(plaintext.Length);

        var ciphertext = new StringBuilder();
        var index = 0;
        foreach (char c in plaintext)
        {
            ciphertext = ciphertext.Append(EncodeCharBy(c, Key[index]));
            index++;
        }
        return ciphertext.ToString();
    }

    private void EnsureKeyLength(int minimumLength)
    {
        if (minimumLength > Key.Length)
        {
            _key = RepeatUntilLength(Key, minimumLength);
        }
    }

    private string RepeatUntilLength(string key, int length) => string.Concat(Enumerable.Repeat(key, (length / key.Length) + 1)).Substring(0, length);
    private char EncodeCharBy(char textChar, char keyChar) => (char)((textChar - 'a' + keyChar - 'a') % 26 + 'a');
    private char DecodeCharBy(char textChar, char keyChar) => (char)((textChar - 'a' - keyChar + 'a' + 26) % 26 + 'a');

    public string Decode(string ciphertext)
    {
        EnsureKeyLength(ciphertext.Length);

        var plaintext = new StringBuilder();
        var index = 0;  
        foreach (char c in ciphertext)
        {
            plaintext = plaintext.Append(DecodeCharBy(c, Key[index]));
            index++;
        }
        return plaintext.ToString();
    }
}