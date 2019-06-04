import 'package:intl/date_symbol_data_local.dart';
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

  test('isLeapYear goes well', () {
    expect(DateCalc(2019).isLeapYear(), false);
    expect(DateCalc(2020).isLeapYear(), true);
    expect(DateCalc(2100).isLeapYear(), false);
    expect(DateCalc(2000).isLeapYear(), true);
    expect(DateCalc.isLeapYearFor(2000), true);
  });

  test('daysInMonth returns days in month', () {
    expect(DateCalc(2019, 1).daysInMonth(), 31);
    expect(DateCalc(2019, 2).daysInMonth(), 28);
    expect(DateCalc(2019, 3).daysInMonth(), 31);
    expect(DateCalc(2019, 4).daysInMonth(), 30);
    expect(DateCalc(2019, 5).daysInMonth(), 31);
    expect(DateCalc(2019, 6).daysInMonth(), 30);
    expect(DateCalc(2019, 7).daysInMonth(), 31);
    expect(DateCalc(2019, 8).daysInMonth(), 31);
    expect(DateCalc(2019, 9).daysInMonth(), 30);
    expect(DateCalc(2019, 10).daysInMonth(), 31);
    expect(DateCalc(2019, 11).daysInMonth(), 30);
    expect(DateCalc(2019, 12).daysInMonth(), 31);
    expect(DateCalc(2020, 2).daysInMonth(), 29);
    expect(DateCalc.daysInMonthOf(year: 2020, month: 2), 29);
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

  test('utc constructs utc', () {
    final t = DateCalc.now();
    expect(DateCalc.utc(t.year, t.month, t.day).isUtc, true);
    expect(DateCalc(t.year, t.month, t.day).isUtc, false);
  });

  test('dup constructs dup', () {
    final t = DateCalc.now();
    expect(t.dup() == t, true);
    expect(t.dup(day: t.day + 1) == t.add(Duration(days: 1)), true);
  });

  test('parse returns correct DateCalc instance', () {
    expect(DateCalc.parse('2019-01-02 03:45:06') is DateCalc, true);
    expect(
        DateCalc.parse('2019-01-02 03:45:06') ==
            DateTime.parse('2019-01-02 03:45:06'),
        true);
  });

  test('add years go well', () {
    expectDate(DateCalc(2010, 1, 1).addYear(1), 2011, 1, 1);
    expectDate(DateCalc(2019, 1, 1).addYear(1), 2020, 1, 1);
    expectDate(DateCalc(2020, 2, 29).addYear(1), 2021, 2, 28);
  });

  test('add months go well', () {
    expectDate(DateCalc(2019, 12, 1).addMonth(1), 2020, 1, 1);
    expectDate(DateCalc(2019, 1, 1).addMonth(1), 2019, 2, 1);
    expectDate(DateCalc(2019, 1, 31).addMonth(1), 2019, 2, 28);
    expectDate(DateCalc(2020, 1, 31).addMonth(1), 2020, 2, 29);
    expectDate(DateCalc(2019, 1, 31).addMonth(13), 2020, 2, 29);
  });

  test('add days go well', () {
    final t = DateCalc.now();
    expect(t.addDay(1) == t.add(Duration(days: 1)), true);
    expect(t.addDay(31) == t.add(Duration(days: 31)), true);
    expectDate(DateCalc(2019, 2, 28).addDay(365), 2020, 2, 28);
    expectDate(DateCalc(2019, 2, 28).addDay(366), 2020, 2, 29);
    expectDate(DateCalc(2019, 2, 28).addDay(367), 2020, 3, 1);
  });

  test('subtract years go well', () {
    expectDate(DateCalc(2011, 1, 1).subtractYear(1), 2010, 1, 1);
    expectDate(DateCalc(2020, 1, 1).subtractYear(1), 2019, 1, 1);
    expectDate(DateCalc(2020, 2, 29).subtractYear(1), 2019, 2, 28);
  });

  test('subtract months go well', () {
    expectDate(DateCalc(2020, 1, 31).subtractMonth(1), 2019, 12, 31);
    expectDate(DateCalc(2020, 5, 31).subtractMonth(3), 2020, 2, 29);
    expectDate(DateCalc(2020, 2, 29).subtractMonth(12), 2019, 2, 28);
  });

  test('subtract days go well', () {
    final t = DateCalc.now();
    expect(t.subtractDay(1) == t.subtract(Duration(days: 1)), true);
    expect(t.subtractDay(31) == t.subtract(Duration(days: 31)), true);
    expectDate(DateCalc(2020, 3, 1).subtractDay(367), 2019, 2, 28);
    expectDate(DateCalc(2020, 2, 29).subtractDay(366), 2019, 2, 28);
    expectDate(DateCalc(2020, 2, 28).subtractDay(365), 2019, 2, 28);
  });

  test('differenceValue returns correct year value', () {
    expect(
        DateCalc(2020, 1, 1)
            .differenceValue(date: DateTime(2020, 1, 2), type: DateType.year),
        0);
    expect(
        DateCalc(2020, 1, 1)
            .differenceValue(date: DateTime(2021, 1, 2), type: DateType.year),
        1);
    expect(
        DateCalc(2020, 1, 3)
            .differenceValue(date: DateTime(2021, 1, 2), type: DateType.year),
        0);
    expect(
        DateCalc(2020, 4, 5)
            .differenceValue(date: DateTime(2019, 1, 2), type: DateType.year),
        1);
  });

  test('differenceValue returns correct month value', () {
    expect(
        DateCalc(2020, 1, 1)
            .differenceValue(date: DateTime(2020, 1, 2), type: DateType.month),
        0);
    expect(
        DateCalc(2020, 1, 1)
            .differenceValue(date: DateTime(2021, 1, 2), type: DateType.month),
        12);
    expect(
        DateCalc(2020, 1, 3)
            .differenceValue(date: DateTime(2021, 1, 2), type: DateType.month),
        11);
    expect(
        DateCalc(2020, 4, 5)
            .differenceValue(date: DateTime(2019, 1, 2), type: DateType.month),
        15);
  });

  test('differenceValue returns correct day value', () {
    expect(
        DateCalc(2020, 1, 1, 13, 45).differenceValue(
            date: DateTime(2020, 1, 2, 12, 50), type: DateType.day),
        0);
    expect(
        DateCalc(2020, 1, 1, 12, 45).differenceValue(
            date: DateTime(2021, 1, 2, 12, 50), type: DateType.day),
        367);
    expect(
        DateCalc(2020, 2, 3, 12, 45).differenceValue(
            date: DateTime(2020, 3, 4, 12, 50), type: DateType.day),
        30);
    expect(
        DateCalc(2020, 1, 1)
            .differenceValue(date: DateTime(2020, 2, 1), type: DateType.day),
        31);
    expect(
        DateCalc(2020, 2, 1)
            .differenceValue(date: DateTime(2020, 1, 1), type: DateType.day),
        31);
  });

  test('differenceValue returns correct other values', () {
    expect(
        DateCalc(2020, 1, 1, 13, 45).differenceValue(
            date: DateTime(2020, 1, 1, 12, 50), type: DateType.hour),
        0);
    expect(
        DateCalc(2020, 1, 1, 13, 45).differenceValue(
            date: DateTime(2020, 1, 1, 12, 45), type: DateType.hour),
        1);
    expect(
        DateCalc(2020, 1, 1, 12, 45, 5).differenceValue(
            date: DateTime(2020, 1, 1, 12, 44, 50), type: DateType.minute),
        0);
    expect(
        DateCalc(2020, 1, 1, 12, 45, 5).differenceValue(
            date: DateTime(2020, 1, 1, 12, 44, 5), type: DateType.minute),
        1);
    expect(
        DateCalc(2020, 1, 1, 12, 45, 5, 30).differenceValue(
            date: DateTime(2020, 1, 1, 12, 45, 4, 50), type: DateType.second),
        0);
    expect(
        DateCalc(2020, 1, 1, 12, 45, 5, 50).differenceValue(
            date: DateTime(2020, 1, 1, 12, 45, 4, 50), type: DateType.second),
        1);
  });

  test('toDate returns DateTime instance', () {
    expect(DateCalc.now().toDate() is DateTime, true);
    expect(DateCalc.now().toDate() is DateCalc, false);
  });

  test('toFormattedString returns formatted string', () {
    final t = DateCalc(2019, 1, 2, 3, 45);
    expect(t.toFormattedString(), 'January 2, 2019 3:45:00 AM');
    expect(t.toFormattedString('yMd'), '1/2/2019');
    initializeDateFormatting('ja_JP');
    expect(t.toFormattedString('MMMM', 'ja_JP'), '1月');
  });
}

void expectDate(DateTime date, int y, [int m = 1, int d = 1]) {
  expect(date, DateTime(y, m, d));
}
