library date_calc;

import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

enum DateType { year, month, day, hour, minute, second }

class DateCalc extends DateTime {
  /// Days count in a month.
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

  /// Constructs a [DateCalc] instance specified in the local time zone.
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

  /// Constructs a [DateCalc] instance specified in the UTC time zone.
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

  /// Constructs a [DateCalc] instance from a [DateTime] instance.
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

  /// Constructs a [DateCalc] instance with current date and time in the
  /// local time zone.
  DateCalc.now() : super.now();

  /// Constructs a [DateCalc] instance duplicated.
  /// When pass some arguments, the [DateCalc] instance reflects it.
  /// DateCalc(2020, 01, 01).dup() => 2020-01-01 00:00:00.000
  /// DateCalc(2020, 01, 01).dup(day: 2, hour: 1) => 2020-01-02 01:00:00.000
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

  /// Returns a [DateCalc] instance based on [formattedString].
  /// DateCalc.parse('2019-01-02 03:45:06')
  /// => 2019-01-02 03:45:06.000
  static DateCalc parse(String formattedString) =>
      DateCalc.fromDateTime(DateTime.parse(formattedString));

  /// Returns true if given year is a leap year.
  /// DateCalc.isLeapYearFor(2020)
  /// => true
  static bool isLeapYearFor(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  /// Returns days count of given year and month.
  /// DateCalc.daysInMonthOf(year: 2020, month: 2)
  /// => 29
  static int daysInMonthOf({@required int year, @required int month}) =>
      (month == DateTime.february && isLeapYearFor(year))
          ? _daysInMonth['leap']
          : _daysInMonth[month];

  /// Returns a [DateCalc] instance with the beginning time of the day.
  /// DateCalc(2020, 2, 5).beginningOfDay()
  /// => 2020-02-05 00:00:00.000
  DateCalc beginningOfDay() => DateCalc(year, month, day);

  /// Returns a [DateCalc] instance with the end time of the day.
  /// End time means '23:59:59.999', not '23:59:59.999.999'.
  /// DateCalc(2020, 2, 5).endOfDay()
  /// => 2020-02-05 23:59:59.999
  DateCalc endOfDay() => DateCalc.fromDateTime(
      DateTime(year, month, day + 1).subtract(Duration(milliseconds: 1)));

  /// Returns a [DateCalc] instance with the beginning time of the month.
  /// DateCalc(2020, 2, 5).beginningOfMonth()
  /// => 2020-02-01 00:00:00.000
  DateCalc beginningOfMonth() => DateCalc(year, month);

  /// Returns a [DateCalc] instance with the end day and time of the month.
  /// End time means '23:59:59.999', not '23:59:59.999.999'.
  /// DateCalc(2020, 2, 5).endOfMonth()
  /// => 2020-02-29 23:59:59.999
  DateCalc endOfMonth() => DateCalc.fromDateTime(
      DateTime(year, month + 1).subtract(Duration(milliseconds: 1)));

  /// Returns true if self and given [date] are the same day.
  /// DateCalc(2020, 2, 5).isSameDay(DateTime(2020, 2, 5))
  /// => true
  bool isSameDay(DateTime date) =>
      year == date.year && month == date.month && day == date.day;

  /// Returns true if self and given [date] are the different day.
  /// DateCalc(2020, 2, 5).isNotSameDay(DateTime(2020, 2, 5))
  /// => false
  bool isNotSameDay(DateTime date) => !isSameDay(date);

  /// Returns true if self is today.
  /// DateTime.now() => 2020-02-05 00:00:00.000
  /// DateCalc(2020, 2, 5).isToday()
  /// => true
  bool isToday() => isSameDay(DateTime.now());

  /// Returns true if self is a leap year.
  /// DateCalc(2020, 2, 5).isLeapYearFor()
  /// => true
  bool isLeapYear() => isLeapYearFor(year);

  /// Returns days count of self.
  /// DateCalc(2020, 2, 5).daysInMonthOf()
  /// => 29
  int daysInMonth() => daysInMonthOf(year: year, month: month);

  /// Returns a [DateCalc] instance added years.
  /// If there is no corresponding day, returns the end day of the month insted.
  /// DateCalc(2020, 2, 29).addYear(1)
  /// => 2021-02-28 00:00:00.000
  DateCalc addYear(int other) {
    final result = dup(year: year + other);
    return result.month == month
        ? result
        : result.dup(
            month: month,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  /// Returns a [DateCalc] instance added months.
  /// If there is no corresponding day, returns the end day of the month insted.
  /// DateCalc(2020, 1, 31).addMonth(1)
  /// => 2020-02-29 00:00:00.000
  DateCalc addMonth(int other) {
    final result = dup(month: month + other);
    return result.day == day
        ? result
        : result.dup(
            month: result.month - 1,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  /// Returns a [DateCalc] instance added days.
  DateCalc addDay(int other) => dup(day: day + other);

  /// Returns a [DateCalc] instance added hours.
  DateCalc addHour(int other) => dup(hour: hour + other);

  /// Returns a [DateCalc] instance added minutes.
  DateCalc addMinute(int other) => dup(minute: minute + other);

  /// Returns a [DateCalc] instance added seconds.
  DateCalc addSecond(int other) => dup(second: second + other);

  /// Returns a [DateCalc] instance added milliseconds.
  DateCalc addMillisecond(int other) => dup(millisecond: millisecond + other);

  /// Returns a [DateCalc] instance added microseconds.
  DateCalc addMicrosecond(int other) => dup(microsecond: microsecond + other);

  /// Returns a [DateCalc] instance subtracted years.
  /// If there is no corresponding day, returns the end day of month insted.
  /// DateCalc(2020, 2, 29).subtractYear(1)
  /// => 2019-02-28 00:00:00.000
  DateCalc subtractYear(int other) {
    final result = dup(year: year - other);
    return result.month == month
        ? result
        : result.dup(
            month: month,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  /// Returns a [DateCalc] instance subtracted months.
  /// If there is no corresponding day, returns the end day of month insted.
  /// DateCalc(2020, 3, 31).subtractMonth(1)
  /// => 2020-02-29 00:00:00.000
  DateCalc subtractMonth(int other) {
    final result = dup(month: month - other);
    return result.day == day
        ? result
        : result.dup(
            month: result.month - 1,
            day: daysInMonthOf(year: result.year, month: result.month - 1),
          );
  }

  /// Returns a [DateCalc] instance subtracted days.
  DateCalc subtractDay(int other) => dup(day: day - other);

  /// Returns a [DateCalc] instance subtracted hours.
  DateCalc subtractHour(int other) => dup(hour: hour - other);

  /// Returns a [DateCalc] instance subtracted minutes.
  DateCalc subtractMinute(int other) => dup(minute: minute - other);

  /// Returns a [DateCalc] instance subtracted seconds.
  DateCalc subtractSecond(int other) => dup(second: second - other);

  /// Returns a [DateCalc] instance subtracted milliseconds.
  DateCalc subtractMillisecond(int other) =>
      dup(millisecond: millisecond - other);

  /// Returns a [DateCalc] instance subtracted microseconds.
  DateCalc subtractMicrosecond(int other) =>
      dup(microsecond: microsecond - other);

  DateCalc operator +(Map<DateType, int> other) {
    switch (other.keys.first) {
      case DateType.year:
        return addYear(other.values.first);
      case DateType.month:
        return addMonth(other.values.first);
      case DateType.day:
        return addDay(other.values.first);
      case DateType.hour:
        return addHour(other.values.first);
      case DateType.minute:
        return addMinute(other.values.first);
      case DateType.second:
        return addSecond(other.values.first);
      default:
      // do nothing
    }
  }

  DateCalc operator -(Map<DateType, int> other) {
    switch (other.keys.first) {
      case DateType.year:
        return subtractYear(other.values.first);
      case DateType.month:
        return subtractMonth(other.values.first);
      case DateType.day:
        return subtractDay(other.values.first);
      case DateType.hour:
        return subtractHour(other.values.first);
      case DateType.minute:
        return subtractMinute(other.values.first);
      case DateType.second:
        return subtractSecond(other.values.first);
      default:
      // do nothing
    }
  }

  /// Returns int of given type.
  /// When no given date, calcurate self and DateTime.now().
  /// DateCalc(2020, 1, 5).differenceValue(date: DateTime(2020, 3, 3), type: DateType.month)
  /// => 1
  /// DateTime.now() => 2020, 2, 3
  /// DateCalc(2020, 1, 2).differenceValue(type: DateType.month)
  /// => 1
  int differenceValue({DateTime date, @required DateType type}) {
    final other = date == null ? DateCalc.now() : DateCalc.fromDateTime(date);
    final e = isBefore(other) ? this : other;
    final l = isBefore(other) ? other : this;
    int result;

    switch (type) {
      case DateType.year:
        result = (l.year - e.year) + (e.dup(year: l.year).isAfter(l) ? -1 : 0);
        break;
      case DateType.month:
        result = (l.year - e.year) * 12 +
            (l.month - e.month) +
            (e.dup(year: l.year, month: l.month).isAfter(l) ? -1 : 0);
        break;
      case DateType.day:
        result = l.difference(e).inDays;
        break;
      case DateType.hour:
        result = l.difference(e).inHours;
        break;
      case DateType.minute:
        result = l.difference(e).inMinutes;
        break;
      case DateType.second:
        result = l.difference(e).inSeconds;
        break;
      default:
      // do nothing
    }
    return result;
  }

  /// Returns a [DateTime] instance.
  DateTime toDate() {
    return isUtc
        ? DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond)
        : DateTime.utc(
            year, month, day, hour, minute, second, millisecond, microsecond);
  }

  /// Returns fomatted string by [DateFormat].
  /// This method provides simply parsing.
  /// When you need some extra methods like parseLoose or add_m,
  /// you can use [DateFormat] itself.
  ///
  /// DateCalc(2019, 2, 1).toFormattedString()
  /// => February 1, 2019 12:00:00 AM
  /// DateCalc(2019, 2, 1).toFormattedString('yMd')
  /// => 2/1/2019
  /// DateCalc(2019, 2, 1).toFormattedString('yMd', 'ja_JP')
  /// => 2019/2/1
  ///
  /// You can check usable locale in [dateTimePatternMap]
  /// in intl/date_time_patterns.dart.
  /// Call [initializeDateFormatting(locale)], then do [toFormattedString].
  String toFormattedString([String format, String locale]) {
    return DateFormat(format, locale).format(this);
  }
}
