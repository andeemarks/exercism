class SecretHandshake {
  List<String> commands( int i) {
    List<String> result = List.empty(growable: true);
    if (i & 1 == 1) result.add('wink');
    if (i & 2 == 2) result.add('double blink');
    if (i & 4 == 4) result.add('close your eyes');
    if (i & 8 == 8) result.add('jump');

    return (i & 16 == 16) ? result.reversed.toList() : result;
  }
}
