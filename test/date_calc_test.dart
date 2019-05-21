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

  test('utc constructor creates utc', () {
    final t = DateCalc.now();
    expect(DateCalc.utc(t.year, t.month, t.day).isUtc, true);
    expect(DateCalc(t.year, t.month, t.day).isUtc, false);
  });

  test('dup creates dup', () {
    final t = DateCalc.now();
    expect(t.dup() == t, true);
    expect(t.dup(day: t.day + 1) == t.add(Duration(days: 1)), true);
  });
}
