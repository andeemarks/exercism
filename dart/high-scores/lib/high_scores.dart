class HighScores {
  List<int> scores;

  HighScores(this.scores) {

  }

  int latest() {
    return this.scores.last;
  }

  List _sortScores() {
    List sortedScores = List.generate(this.scores.length, (i) => 0);
    List.copyRange(sortedScores, 0, this.scores);
    sortedScores.sort();

    return sortedScores;
  }

  int personalBest() {
    return _sortScores().last;
  }

  List personalTopThree() {
    return _sortScores().reversed.toList().take(3).toList();
  }
}
