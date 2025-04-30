import 'dart:math';

class MathLockService {
  late int _a, _b;

  void generate() {
    final rnd = Random();
    _a = rnd.nextInt(9) + 1;
    _b = rnd.nextInt(9) + 1;
  }

  String get question => '$_a + $_b = ?';

  bool check(String answer) => int.tryParse(answer) == _a + _b;
}
