library date_calc;

class DateCalc extends DateTime {
  DateCalc(int year,
      [int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0])
      : super(
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  DateCalc.now() : super.now();

  DateCalc beginningOfDay() => DateCalc(year, month, day);

  bool isSameDay(DateTime date) =>
      year == date.year && month == date.month && day == date.day;
  bool isNotSameDay(DateTime date) => !isSameDay(date);
  bool isToday() => isSameDay(DateTime.now());
}
