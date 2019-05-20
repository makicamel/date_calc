import 'package:flutter_test/flutter_test.dart';
import 'package:date_calc/date_calc.dart';

void main() {
  test('Yesterday isSameDay yesterday, yesrterday isNotSameDay today', () {
    final t = DateTime.now();
    expect(
        DateCalc(t.year, t.month, t.day - 1)
            .isSameDay(DateTime(t.year, t.month, t.day - 1)),
        true);
    expect(DateCalc(t.year, t.month, t.day - 1).isSameDay(t), false);
    expect(
        DateCalc(t.year, t.month, t.day - 1)
            .isNotSameDay(DateTime(t.year, t.month, t.day - 1)),
        false);
    expect(DateCalc(t.year, t.month, t.day - 1).isNotSameDay(t), true);
  });

  test('Yesterday !isToday, today isToday', () {
    final t = DateTime.now();
    expect(DateCalc(t.year, t.month, t.day - 1).isToday(), false);
    expect(DateCalc(t.year, t.month, t.day).isToday(), true);
  });

  test('beginningOfDay is beginning of the day', () {
    final t = DateCalc.now();
    expect(t.beginningOfDay() == DateTime(t.year, t.month, t.day), true);
    expect(t.beginningOfDay() == DateTime.now(), false);
  });
}
