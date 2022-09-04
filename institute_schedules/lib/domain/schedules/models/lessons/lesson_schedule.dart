import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import '../../interfaces/lesson_repository.dart';
import '../../entities/date.dart';
import '../../entities/day.dart';
import '../../entities/week.dart';

abstract class LessonSchedule extends ChangeNotifier {
  @protected
  final LessonRepository lessonRepository =
  GetIt.instance.get<LessonRepository>();

  final List<Lesson> _lessons = [];

  bool _loading = false;

  bool _loadingCompleted = true;

  bool get isLoading => _loading;

  bool get isLoadingCompleted => _loadingCompleted;

  List<Lesson> getLessonsByWeekTypeAndDayType(WeekType week, DayType day) {
    if (week == WeekType.odd) {
      switch (day) {
        case DayType.monday:
          return oddWeekMondayLessons;

        case DayType.tuesday:
          return oddWeekTuesdayLessons;

        case DayType.wednesday:
          return oddWeekWednesdayLessons;

        case DayType.thursday:
          return oddWeekThursdayLessons;

        case DayType.friday:
          return oddWeekFridayLessons;

        case DayType.saturday:
          return oddWeekSaturdayLessons;
      }
    }

    switch (day) {
      case DayType.monday:
        return evenWeekMondayLessons;

      case DayType.tuesday:
        return evenWeekTuesdayLessons;

      case DayType.wednesday:
        return evenWeekWednesdayLessons;

      case DayType.thursday:
        return evenWeekThursdayLessons;

      case DayType.friday:
        return evenWeekFridayLessons;

      case DayType.saturday:
        return evenWeekSaturdayLessons;
    }
  }

  List<Lesson> getLessonByDate(Date date) {
    if (date.toDateTime.weekday == 7) {
      return [];
    }

    List<Lesson> lessons = [];

    for (var lesson in _lessons) {
      if (_doesDateIncludeLesson(date, lesson)) {
        lessons.add(lesson);
      }
    }

    lessons.sort((lesson1, lesson2) {
      return lesson1.number.compareTo(lesson2.number);
    });

    return lessons;
  }

  bool _doesDateIncludeLesson(Date date, Lesson lesson) {

    final weekType = Week.getWeekTypeByDate(date);

    final dayType = Day.getDayTypeByDate(date);

    if (weekType != lesson.weekType || dayType != lesson.dayType) {
      return false;
    }

    DateTime _date = date.toDateTime;

    var lessonDate = lesson.dateOfBegin.toDateTime;

    if (lessonDate.year == _date.year &&
        lessonDate.month == _date.month &&
        lessonDate.day == _date.day) {
      return true;
    }

    var lessonBeginInMicroSec =
        lesson.dateOfBegin.toDateTime.microsecondsSinceEpoch;

    var lessonEndInMicroSec =
        lesson.dateOfEnd.toDateTime.microsecondsSinceEpoch;

    var dateInMicroSec = _date.microsecondsSinceEpoch;

    if (lessonBeginInMicroSec <= dateInMicroSec &&
        dateInMicroSec <= lessonEndInMicroSec) {
      return true;
    }
    return false;
  }

  /// Update lesson's schedule
  void update() {
    _loading = true;

    _loadingCompleted = false;

    notifyListeners();


    load().then((value) {
      _lessons.clear();

      _lessons.addAll(value);

      _loading = false;

      _loadingCompleted = true;

      notifyListeners();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Возникла ошибка, проверте соединение с интернетом",
          fontSize: 14,
          gravity: ToastGravity.BOTTOM
      );
      _lessons.clear();
      _loading = false;
      _loadingCompleted = true;
      notifyListeners();
    });
  }

  List<Lesson> get oddWeekMondayLessons  {
    var result = <Lesson>[];

    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.odd && lesson.dayType == DayType.monday) {
        result.add(lesson);
      }
    }

    return result;
  }

  List<Lesson> get oddWeekTuesdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.odd &&
          lesson.dayType == DayType.tuesday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get oddWeekWednesdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.odd &&
          lesson.dayType == DayType.wednesday) {
        result.add(lesson);
      }
    }

    return result;
  }

  List<Lesson> get oddWeekThursdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.odd &&
          lesson.dayType == DayType.thursday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get oddWeekFridayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.odd && lesson.dayType == DayType.friday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get oddWeekSaturdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.odd &&
          lesson.dayType == DayType.saturday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get evenWeekMondayLessons {
    var result = <Lesson>[];

    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.even &&
          lesson.dayType == DayType.monday) {
        result.add(lesson);
      }
    }

    return result;
  }

  List<Lesson> get evenWeekTuesdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.even &&
          lesson.dayType == DayType.tuesday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get evenWeekWednesdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.even &&
          lesson.dayType == DayType.wednesday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get evenWeekThursdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.even &&
          lesson.dayType == DayType.thursday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get evenWeekFridayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.even &&
          lesson.dayType == DayType.friday) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> get evenWeekSaturdayLessons {
    var result = <Lesson>[];
    for (var lesson in _lessons) {
      if (lesson.weekType == WeekType.even &&
          lesson.dayType == DayType.saturday) {
        result.add(lesson);
      }
    }
    return result;
  }

  /// Don't call this method by yourself
  ///
  /// This method is called from the base class
  @protected
  Future<List<Lesson>> load();
}
