using System.Text;

public class SimpleCipher
{
    private string _key;

    public SimpleCipher() => _key = RandomLowercaseString(100);

    public SimpleCipher(string key) => _key = key;

    public string Key =>
        // If no key is provided, generate a key which consists of at least 
        // 100 random lowercase letters from the Latin alphabet.

        _key;

    private string RandomLowercaseString(int length)
    {
        const string chars = "abcdefghijklmnopqrstuvwxyz";

        return new string([.. Enumerable.Repeat(chars, length).Select(s => s[Random.Shared.Next(s.Length)])]);
    }

    public string Encode(string plaintext)
    {
        if (plaintext.Length > Key.Length)
        {
            _key = RepeatUntilLength(Key, plaintext.Length);
        }

        var ciphertext = new StringBuilder();
        var index = 0;  
        foreach (char c in plaintext)
        {
            ciphertext = ciphertext.Append(EncodeCharBy(c, Key[index]));
            index++;
        }
        return ciphertext.ToString();
    }

    private string RepeatUntilLength(string key, int length) => string.Concat(Enumerable.Repeat(key, (length / key.Length) + 1)).Substring(0, length);
    private char EncodeCharBy(char plaintextChar, char keyChar) => (char)((plaintextChar - 'a' + keyChar - 'a') % 26 + 'a');
    private char DecodeCharBy(char ciphertextChar, char keyChar) => (char)((ciphertextChar - 'a' - keyChar + 'a' + 26) % 26 + 'a');

    public string Decode(string ciphertext)
    {
        if (ciphertext.Length > Key.Length)
        {
            _key = RepeatUntilLength(Key, ciphertext.Length);
        }

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