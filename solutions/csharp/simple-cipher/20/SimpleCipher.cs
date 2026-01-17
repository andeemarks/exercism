using System.Text;

public class SimpleCipher
{
    private string _key;

    public SimpleCipher() => _key = RandomLowercaseString(100);

    public SimpleCipher(string key) => _key = key;

    public string Key => _key;

    public string Encode(string plaintext) => NewMethod(plaintext, EncodeCharWith);
    public string Decode(string ciphertext) => NewMethod(ciphertext, DecodeCharWith);

    private string NewMethod(string plaintext, TextCoder coder)
    {
        var ciphertext = new StringBuilder();
        for (var i = 0; i < plaintext.Length; i++)
        {
            ciphertext = ciphertext.Append(coder(plaintext[i], Key[i % Key.Length]));
        }
        return ciphertext.ToString();
    }

    private static string RandomLowercaseString(int length)
    {
        const string alphabet = "abcdefghijklmnopqrstuvwxyz";

        return new string([.. Enumerable.Repeat(alphabet, length).Select(s => s[Random.Shared.Next(s.Length)])]);
    }

    public delegate char TextCoder(char textChar, char keyChar);
    private static char EncodeCharWith(char textChar, char keyChar) => CodeChar(textChar - 'a' + keyChar - 'a');
    private static char DecodeCharWith(char textChar, char keyChar) => CodeChar(textChar - 'a' - keyChar + 'a' + 26);
    private static char CodeChar(int textChar) => (char)(textChar % 26 + 'a');
}