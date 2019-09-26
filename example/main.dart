import 'package:date_calc/date_calc.dart';

void main() {
  final date = DateCalc(2019, 1, 5);
  print(date.addMonth(1));
  // => 2019-02-05 00:00:00.000
  print(date.addYear(1).isLeapYear());
  // => true
  print(date.addYear(1).addMonth(1).daysInMonth());
  // => 29
  print(date.dup(minute: 11));
  // => 2019-01-05 00:11:00.000
  print(date.differenceValue(date: DateTime(2019, 3, 3), type: DateType.month));
  // => 1
  print(DateCalc.now().isToday());
  // => true

  // You can cast type from DateCalc to DateTime.
  print(DateCalc(2019, 1, 5).subtractYear(1).toDate().runtimeType);
  // => DateTime
}
