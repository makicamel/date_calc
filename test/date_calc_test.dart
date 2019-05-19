import 'package:flutter_test/flutter_test.dart';

import 'package:date_calc/date_calc.dart';

void main() {
  test('adds one to input values', () {
    final calculator = DateCalc(2019);
    expect(calculator.isSameDate(DateTime.now()), true);
  });
}
