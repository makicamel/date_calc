library date_calc;

import 'package:meta/meta.dart';

class DateCalc extends DateTime {
  static final _daysInMonth = {
    1: 31,
    2: 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
    'leap': 29,
  };

  DateCalc(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : super(
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  DateCalc.utc(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : super.utc(
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  DateCalc.fromDateTime(DateTime date)
      : super(
          date.year,
          date.month,
          date.day,
          date.hour,
          date.minute,
          date.second,
          date.millisecond,
          date.microsecond,
        );

  DateCalc.now() : super.now();

  // Returns DateCalc instance duplicated.
  // When pass some arguments, DateCalc instance reflects it.
  // DateCalc(2020, 01, 01).dup() => 2020-01-01 00:00:00.000
  // DateCalc(2020, 01, 01).dup(day: 2, hour: 1) => 2020-01-02 01:00:00.000
  DateCalc dup({
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int millisecond,
    int microsecond,
  }) {
    return DateCalc(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  static bool isLeapYearFor([int year]) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  // Returns days counts of received year and month.
  static int daysInMonthOf({@required int year, @required int month}) =>
      (month == DateTime.february && isLeapYearFor(year))
          ? _daysInMonth['leap']
          : _daysInMonth[month];

  DateCalc beginningOfDay() => DateCalc(year, month, day);

  DateCalc endOfDay() => DateCalc.fromDateTime(
      DateTime(year, month, day + 1).subtract(Duration(milliseconds: 1)));

  DateCalc beginningOfMonth() => DateCalc(year, month);

  DateCalc endOfMonth() => DateCalc.fromDateTime(
      DateTime(year, month + 1).subtract(Duration(milliseconds: 1)));

  bool isSameDay(DateTime date) =>
      year == date.year && month == date.month && day == date.day;

  bool isNotSameDay(DateTime date) => !isSameDay(date);

  bool isToday() => isSameDay(DateTime.now());

  bool isLeapYear() => isLeapYearFor(year);

  int daysInMonth() => daysInMonthOf(year: year, month: month);

  // Returns new DateCalc instance added years.
  // If there is no corresponding day, returns the end day of month insted.
  DateCalc addYear(int other) {
    final result = dup(year: year + other);
    return result.month == month
        ? result
        : result.dup(
            month: month,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  // Returns new DateCalc instance added months.
  // If there is no corresponding day, returns the end day of month insted.
  DateCalc addMonth(int other) {
    final result = dup(month: month + other);
    return result.day == day
        ? result
        : result.dup(
            month: result.month - 1,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  DateCalc addDay(int other) => dup(day: day + other);

  // Returns new DateCalc instance subtracted years.
  // If there is no corresponding day, returns the end day of month insted.
  DateCalc subtractYear(int other) {
    final result = dup(year: year - other);
    return result.month == month
        ? result
        : result.dup(
            month: month,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  // Returns new DateCalc instance subtracted months.
  // If there is no corresponding day, returns the end day of month insted.
  DateCalc subtractMonth(int other) {
    final result = dup(month: month - other);
    return result.day == day
        ? result
        : result.dup(
            month: result.month - 1,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  DateCalc subtractDay(int other) => dup(day: day - other);
  }

  DateTime toDate() {
    return isUtc
        ? DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond)
        : DateTime.utc(
            year, month, day, hour, minute, second, millisecond, microsecond);
  }
}
