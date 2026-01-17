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
        for (var i = 0; i < plaintext.Length; i++)
        {
            ciphertext = ciphertext.Append(EncodeCharBy(plaintext[i], Key[i]));
        }
        return ciphertext.ToString();
    }

    private void EnsureKeyLength(int minimumLength)
    {
        if (minimumLength > Key.Length)
        {
            _key = GrowUntilLength(Key, minimumLength);
        }
    }

    private static string GrowUntilLength(string text, int length) => string.Concat(Enumerable.Repeat(text, (length / text.Length) + 1))[..length];
    private static char EncodeCharBy(char textChar, char keyChar) => CodeCharBy(textChar - 'a' + keyChar - 'a');
    private static char DecodeCharBy(char textChar, char keyChar) => CodeCharBy(textChar - 'a' - keyChar + 'a' + 26);

    private static char CodeCharBy(int textChar) => (char)(textChar % 26 + 'a');

    public string Decode(string ciphertext)
    {
        EnsureKeyLength(ciphertext.Length);

        var plaintext = new StringBuilder();
        for (var i = 0; i < ciphertext.Length; i++)
        {
            plaintext = plaintext.Append(DecodeCharBy(ciphertext[i], Key[i]));
        }
        return plaintext.ToString();
    }
}