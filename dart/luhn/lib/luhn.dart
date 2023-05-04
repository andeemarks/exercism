import 'package:collection/collection.dart';

class Luhn {
  bool valid(String number) {
    if (number.trim().length <= 1) return false;
    if (RegExp(r'([^\ 0-9])').hasMatch(number)) return false;

    var digitsOnly = number.replaceAll(RegExp(r'[^0-9]'), "").split('');
    var processedDigits = digitsOnly.reversed.mapIndexed((i, digit) => _convertDigit(i, int.parse(digit)));
    var sumOfDigits = processedDigits.reduce((acc, digit) => acc + digit);

    return sumOfDigits % 10 == 0;
  }

  int _convertDigit(int i, int digit) {
    if (i % 2 == 0) {
      return digit;
    } else {
      digit = digit * 2;

      return digit > 9 ? digit - 9 : digit;
    }
  }
}
