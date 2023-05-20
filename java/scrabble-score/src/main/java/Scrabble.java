import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

class Scrabble {

    private static Map<List<Character>, Integer> scores = new HashMap<>();

    static {
        scores.put(List.of('a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't'), 1);
        scores.put(List.of('d', 'g'), 2);
        scores.put(List.of('b', 'c', 'm', 'p'), 3);
        scores.put(List.of('f', 'y', 'h', 'v', 'w'), 4);
        scores.put(List.of('k'), 5);
        scores.put(List.of('j', 'x'), 8);
        scores.put(List.of('q', 'z'), 10);
    }

    private String word;

    Scrabble(String word) {
        this.word = word;
    }

    int getScore() {
        return word
                .toLowerCase()
                .chars()
                .map(letter -> scoreForLetter((char) letter))
                .sum();
    }

    int scoreForLetter(char letter) {
        List<Character> matchingLetters = scores
                .keySet()
                .stream()
                .filter(letters -> letters.contains(letter))
                .findFirst()
                .get();

        return scores.get(matchingLetters);
    }
}
