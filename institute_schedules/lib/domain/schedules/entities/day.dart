import '../exceptions/lesson_not_exists_exception.dart';

import './date.dart';

import './lesson.dart';

enum DayType { monday, tuesday, wednesday, thursday, friday, saturday }

class Day {
  final DayType dayType;
  final List<Lesson> lesson1List;
  final List<Lesson> lesson2List;
  final List<Lesson> lesson3List;
  final List<Lesson> lesson4List;
  final List<Lesson> lesson5List;
  final List<Lesson> lesson6List;
  final List<Lesson> lesson7List;
  final bool militrayDay;

  Day(
      {required this.dayType,
      required this.militrayDay,
      required this.lesson1List,
      required this.lesson2List,
      required this.lesson3List,
      required this.lesson4List,
      required this.lesson5List,
      required this.lesson6List,
      required this.lesson7List}) {
    lesson1List.sort((lesson1, lesson2) {
      return lesson1.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });

    lesson2List.sort((lesson1, lesson2) {
      return lesson2.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });

    lesson3List.sort((lesson1, lesson2) {
      return lesson2.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });

    lesson4List.sort((lesson1, lesson2) {
      return lesson2.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });

    lesson5List.sort((lesson1, lesson2) {
      return lesson2.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });

    lesson6List.sort((lesson1, lesson2) {
      return lesson2.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });

    lesson7List.sort((lesson1, lesson2) {
      return lesson2.dateOfBegin.toDateTime
          .compareTo(lesson2.dateOfBegin.toDateTime);
    });
  }

  Lesson lesson1ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson1List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson1List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }
    throw LessonNotExistsException();
  }

  Lesson lesson2ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson2List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson2List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }
    throw LessonNotExistsException();
  }

  Lesson lesson3ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson3List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson3List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }

    throw LessonNotExistsException();
  }

  Lesson lesson4ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson4List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson4List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }

    throw LessonNotExistsException();
  }

  Lesson lesson5ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson5List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson5List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }

    throw LessonNotExistsException();
  }

  Lesson lesson6ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson6List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson6List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }
    throw LessonNotExistsException();
  }

  Lesson lesson7ByDate(Date date) {
    DateTime _date = date.toDateTime;

    for (var lesson in lesson7List) {
      var lessonDate = lesson.dateOfBegin.toDateTime;
      if (lessonDate.year == _date.year &&
          lessonDate.month == _date.month &&
          lessonDate.day == _date.day) {
        return lesson;
      }
    }

    for (var lesson in lesson7List) {
      var lessonBeginInMicroSec =
          lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

      var lessonEndInMicroSec =
          lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

      var dateInMicroSec = _date.microsecondsSinceEpoch;

      if (lessonBeginInMicroSec <= dateInMicroSec &&
          dateInMicroSec <= lessonEndInMicroSec) {
        return lesson;
      }
    }
    throw LessonNotExistsException();
  }

  static DayType getDayTypeByDate(Date date) {
    switch (date.toDateTime.weekday) {
      case 1:
        return DayType.monday;
      case 2:
        return DayType.tuesday;
      case 3:
        return DayType.wednesday;
      case 4:
        return DayType.thursday;
      case 5:
        return DayType.friday;
      case 6:
        return DayType.saturday;
      default:
        throw Exception("Invalid date");
    }
  }
}
