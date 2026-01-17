using System.Text;

public class SimpleCipher
{
    private string _key;

    public SimpleCipher() => _key = RandomLowercaseString(100);

    public SimpleCipher(string key) => _key = key;

    public string Key => _key;

    public string Encode(string plaintext) => CodeText(plaintext, CharEncoder);
    public string Decode(string ciphertext) => CodeText(ciphertext, CharDecoder);

    private string CodeText(string text, TextCoder coder)
    {
        var codedText = new StringBuilder();
        for (var i = 0; i < text.Length; i++)
        {
            codedText = codedText.Append(coder(text[i], Key[i % Key.Length]));
        }
        return codedText.ToString();
    }

    private static string RandomLowercaseString(int length)
    {
        const string alphabet = "abcdefghijklmnopqrstuvwxyz";

        return new string([.. Enumerable.Repeat(alphabet, length).Select(s => s[Random.Shared.Next(s.Length)])]);
    }

    public delegate char TextCoder(char textChar, char keyChar);
    private static char CharEncoder(char textChar, char keyChar) => CodeChar(textChar - 'a' + keyChar - 'a');
    private static char CharDecoder(char textChar, char keyChar) => CodeChar(textChar - 'a' - keyChar + 'a' + 26);
    private static char CodeChar(int textChar) => (char)(textChar % 26 + 'a');
}