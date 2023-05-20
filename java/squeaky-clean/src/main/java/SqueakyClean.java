import java.text.CharacterIterator;
import java.text.StringCharacterIterator;

class SqueakyClean {
    static String clean(String identifier) {
        StringBuilder cleanIdentifier = new StringBuilder();

        CharacterIterator it = new StringCharacterIterator(identifier);
        Character current = it.current();
        while (current != CharacterIterator.DONE) {
            if (isCamelCase(it)) {
                cleanIdentifier.append(Character.toUpperCase(it.current()));
            }
            if (Character.isLetter(current) && !isGreekLowerLetter(current)) {
                cleanIdentifier.append(current);
            }
            if (Character.isSpaceChar(current)) {
                cleanIdentifier.append("_");
            }
            if (Character.isISOControl(current)) {
                cleanIdentifier.append("CTRL");
            }
            current = it.next();
        }

        return cleanIdentifier.toString();
    }

    private static boolean isCamelCase(CharacterIterator it) {
        return it.current() == '-' && Character.isLetter(it.next());
    }

    private static boolean isGreekLowerLetter(Character letter) {
        return letter >= 'α' && letter <= 'ω';
    }
}
