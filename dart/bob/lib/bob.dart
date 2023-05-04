class Bob {
  String response(String prompt) {
    var includesLetters = prompt.contains(RegExp(r'[a-zA-Z]'));
    var isQuestion = prompt.trim().endsWith("?");
    var isYelling = prompt.toUpperCase() == prompt;
    var isEmpty = prompt.trim().length == 0;

    if (isEmpty) {
      return 'Fine. Be that way!';
    } else if (isQuestion && isYelling && includesLetters) {
      return "Calm down, I know what I'm doing!";
    } else if (isQuestion) {
      return 'Sure.';
    } else if (includesLetters && isYelling) {
      return 'Whoa, chill out!';
    } else {
      return 'Whatever.';
    }
  }
}
