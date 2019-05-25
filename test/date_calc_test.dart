import 'package:test/test.dart';
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

  test('beginningOfDay returns beginning of the day', () {
    final t = DateCalc.now();
    expect(t.beginningOfDay() == DateTime(t.year, t.month, t.day), true);
    expect(t.beginningOfDay() == DateTime.now(), false);
  });

  test('endOfDay returns end of the day', () {
    final t = DateCalc.now();
    expect(t.endOfDay() == DateTime(t.year, t.month, t.day), false);
    expect(
        t.endOfDay().difference(t.beginningOfDay()) ==
            Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999),
        true);
  });

  test('beginningOfMonth returns beginning of the month', () {
    final t1 = DateCalc.now();
    final t2 = DateCalc(2020, 2, 20);
    expect(t1.beginningOfMonth() == DateTime(t1.year, t1.month), true);
    expect(t1.beginningOfMonth() == DateTime.now(), false);
    expect(t2.beginningOfMonth() == DateTime(2020, 2, 1), true);
  });

  test('endOfMonth returns end of the month', () {
    final t1 = DateCalc(2019, 2, 1);
    final t2 = DateCalc(2020, 2, 1);
    expect(t1.endOfMonth().month == 2, true);
    expect(t1.endOfMonth().day == 28, true);
    expect(t2.endOfMonth().month == 2, true);
    expect(t2.endOfMonth().day == 29, true);
    expect(
        t2.endOfMonth().difference(t2.beginningOfMonth()) ==
            Duration(
                days: 28,
                hours: 23,
                minutes: 59,
                seconds: 59,
                milliseconds: 999),
        true);
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

  test('add years go well', () {
    final normal = DateCalc(2010, 1, 1);
    expect(normal.addYear(1) == DateCalc(2011, 1, 1), true);
  });

  test('add months go well', () {
    // expect(DateCalc(2009, 12, 1).addMonth(1) == DateCalc(2010, 1, 1), true);
    // expect(DateCalc(2010, 1, 1).addMonth(1) == DateCalc(2010, 2, 1), true);
    // expect(DateCalc(2010, 1, 31).addMonth(1) == DateCalc(2010, 2, 28), true);
  });

  test('add days go well', () {
    final t = DateCalc.now();
    expect(t.addDay(1) == t.add(Duration(days: 1)), true);
    expect(t.addDay(31) == t.add(Duration(days: 31)), true);
  });
}
