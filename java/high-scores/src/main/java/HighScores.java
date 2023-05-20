import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

class HighScores {

    private List<Integer> scores;

    public HighScores(List<Integer> highScores) {
        this.scores = highScores;
    }

    List<Integer> scores() {
        return this.scores;
    }

    Integer latest() {
        return this.scores.get(this.scores.size() - 1);
    }

    Integer personalBest() {
        return scores.stream().max(Comparator.naturalOrder()).orElse(0);
    }

    List<Integer> personalTopThree() {
        return scores.stream()
                .sorted(Comparator.reverseOrder())
                .limit(3)
                .collect(Collectors.toList());
    }

}
