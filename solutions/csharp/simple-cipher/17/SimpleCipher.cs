using System.Text;

public class SimpleCipher
{
    private string _key;

    public SimpleCipher() => _key = RandomLowercaseString(100);

    public SimpleCipher(string key) => _key = key;

    public string Key => _key;

    public string Encode(string plaintext)
    {
        var ciphertext = new StringBuilder();
        for (var i = 0; i < plaintext.Length; i++)
        {
            ciphertext = ciphertext.Append(EncodeCharWith(plaintext[i], Key[i % Key.Length]));
        }
        return ciphertext.ToString();
    }

    public string Decode(string ciphertext)
    {
        var plaintext = new StringBuilder();
        for (var i = 0; i < ciphertext.Length; i++)
        {
            plaintext = plaintext.Append(DecodeCharWith(ciphertext[i], Key[i % Key.Length]));
        }
        return plaintext.ToString();
    }

    private static string RandomLowercaseString(int length)
    {
        const string alphabet = "abcdefghijklmnopqrstuvwxyz";

        return new string([.. Enumerable.Repeat(alphabet, length).Select(s => s[Random.Shared.Next(s.Length)])]);
    }

    private static string GrowUntilLength(string text, int length) => string.Concat(Enumerable.Repeat(text, (length / text.Length) + 1))[..length];
    private static char EncodeCharWith(char textChar, char keyChar) => CodeChar(textChar - 'a' + keyChar - 'a');
    private static char DecodeCharWith(char textChar, char keyChar) => CodeChar(textChar - 'a' - keyChar + 'a' + 26);
    private static char CodeChar(int textChar) => (char)(textChar % 26 + 'a');
}