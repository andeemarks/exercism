using System.Text;

public class SimpleCipher
{
    private string _key;

    public SimpleCipher() => _key = RandomLowercaseString(100);

    public SimpleCipher(string key) => _key = key;

    public string Key => _key;

    public delegate char TextCoder(char textChar, char keyChar);

    public string Encode(string plaintext)
    {
        return NewMethod(plaintext, EncodeCharWith);
    }

    private string NewMethod(string plaintext, TextCoder coder)
    {
        var ciphertext = new StringBuilder();
        for (var i = 0; i < plaintext.Length; i++)
        {
            ciphertext = ciphertext.Append(coder(plaintext[i], Key[i % Key.Length]));
        }
        return ciphertext.ToString();
    }

    public string Decode(string ciphertext)
    {
        return NewMethod(ciphertext, DecodeCharWith);
    }

    private static string RandomLowercaseString(int length)
    {
        const string alphabet = "abcdefghijklmnopqrstuvwxyz";

        return new string([.. Enumerable.Repeat(alphabet, length).Select(s => s[Random.Shared.Next(s.Length)])]);
    }

    private static char EncodeCharWith(char textChar, char keyChar) => CodeChar(textChar - 'a' + keyChar - 'a');
    private static char DecodeCharWith(char textChar, char keyChar) => CodeChar(textChar - 'a' - keyChar + 'a' + 26);
    private static char CodeChar(int textChar) => (char)(textChar % 26 + 'a');
}