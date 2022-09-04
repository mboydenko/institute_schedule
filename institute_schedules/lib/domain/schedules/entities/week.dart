import 'package:intl/intl.dart';

import './date.dart';

import 'day.dart';

enum WeekType { odd, even, both }

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday
}

class Week {
  final WeekType type;
  final Day monday;
  final Day tuesday;
  final Day wednesday;
  final Day thursday;
  final Day friday;
  final Day saturday;

  Week(
      {required this.type,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday});

  static WeekType getWeekTypeByDate(Date _date, {bool reverse = false}) {
    var date = _date.toDateTime;

    if (date.month < 9) {
      DateTime startDate =
          Date(day: 1, month: 9, year: date.year - 1).toDateTime;

      switch (startDate.weekday) {
        case 1:
          startDate = startDate;
          break;
        case 2:
          startDate = DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: -1));
          break;
        case 3:
          startDate = DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: -2));
          break;
        case 4:
          startDate = DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: -3));
          break;
        case 5:
          startDate = DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: -4));
          break;
        case 6:
          startDate = DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: -5));
          break;
        default:
          startDate = DateTime(startDate.year, startDate.month, startDate.day)
              .add(const Duration(days: -6));
      }

      var numberOfDaysAtLastYear =
          int.parse(DateFormat('D').format(DateTime(date.year - 1, 12, 31)));

      var startDateInDaysNumber = int.parse(DateFormat('D').format(startDate));

      var currentDayInDaysNumber =
          int.parse(DateFormat('D').format(date)) + numberOfDaysAtLastYear;

      var daysFromStart = currentDayInDaysNumber - startDateInDaysNumber;

      var weeksPassed = daysFromStart ~/ 7;

      if (reverse) {
        if (weeksPassed % 2 == 0) {
          return WeekType.even;
        }

        return WeekType.odd;
      }

      if (weeksPassed % 2 == 0) {
        return WeekType.odd;
      }

      return WeekType.even;
    }

    DateTime startDate = Date(day: 1, month: 9, year: date.year).toDateTime;

    switch (startDate.weekday) {
      case 1:
        startDate = startDate;
        break;
      case 2:
        startDate = DateTime(startDate.year, startDate.month, startDate.day)
            .add(const Duration(days: -1));
        break;
      case 3:
        startDate = DateTime(startDate.year, startDate.month, startDate.day)
            .add(const Duration(days: -2));
        break;
      case 4:
        startDate = DateTime(startDate.year, startDate.month, startDate.day)
            .add(const Duration(days: -3));
        break;
      case 5:
        startDate = DateTime(startDate.year, startDate.month, startDate.day)
            .add(const Duration(days: -4));
        break;
      case 6:
        startDate = DateTime(startDate.year, startDate.month, startDate.day)
            .add(const Duration(days: -5));
        break;
      default:
        startDate = DateTime(startDate.year, startDate.month, startDate.day)
            .add(const Duration(days: -6));
    }
    var currentDayInDaysNumber = int.parse(DateFormat('D').format(date));

    var startDateInDaysNumber = int.parse(DateFormat('D').format(startDate));

    var daysFromStart = currentDayInDaysNumber - startDateInDaysNumber;

    var weeksPassed = daysFromStart ~/ 7;

    if (reverse) {
      if (weeksPassed % 2 == 0) {
        return WeekType.even;
      }

      return WeekType.odd;
    }

    if (weeksPassed % 2 == 0) {
      return WeekType.odd;
    }

    return WeekType.even;
  }
}
