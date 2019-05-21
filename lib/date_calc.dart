library date_calc;

class DateCalc extends DateTime {
  // @override
  // int year, month, day;
  // @override
  // int hour, minute, second, millisecond, microsecond;
  // todo:
  // @override
  // bool isUtc;

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

  DateCalc.now() : super.now();

  DateCalc beginningOfDay() => DateCalc(year, month, day);

  bool isSameDay(DateTime date) =>
      year == date.year && month == date.month && day == date.day;

  bool isNotSameDay(DateTime date) => !isSameDay(date);

  bool isToday() => isSameDay(DateTime.now());

  DateCalc addYear(int other) {
    return dup(year: year + other);
  }

  // returns new object added months.
  // if there is no corresponding day, returns the last day insted.
  DateCalc addMonth(int other) {
    final orgDay = day;
    final months = year * 12 + month + other;
    // this.year = (months / 12).floor();
    // this.month = months % 12;

    // fix: get last day
    if (day == orgDay) {
      return dup(year: year, month: month);
    } else {
      return dup(year: year, month: month - 1, day: orgDay);
    }
  }

  DateTime toDate() {
    return isUtc
        ? DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond)
        : DateTime.utc(
            year, month, day, hour, minute, second, millisecond, microsecond);
  }
}
