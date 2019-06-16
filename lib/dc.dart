import 'package:date_calc/date_calc.dart';

class DC {
  static Map<DateType, int> year(int other) => {DateType.year: other};
  static Map<DateType, int> month(int other) => {DateType.month: other};
  static Map<DateType, int> day(int other) => {DateType.day: other};
  static Map<DateType, int> hour(int other) => {DateType.hour: other};
  static Map<DateType, int> minute(int other) => {DateType.minute: other};
  static Map<DateType, int> second(int other) => {DateType.second: other};
}
