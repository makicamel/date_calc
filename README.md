# date_calc

Date manipulation library for easy calculating.

## Usage

### Installation

Add `date_calc` as a dependency in pubspec.yaml file.

```yaml
dependencies:
  date_calc: ^0.1.0
```

Run `pub install`.

### Using

```dart
import 'package:date_calc/date_calc.dart';

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
```

Because DateCalc is a subclass of DateTime, you can use all DateTime methods.  
When you need exactly DateTime object, use `toDate()` method.

```dart
final date = DateCalc(2019, 1, 5);
date.subtractYear(1).toDate();
```

## milestones for 1.0.0

- support for DST
- support for UTC & Timezone
- support for leapsecond
