import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/domain/schedules/models/lessons/lesson_schedule.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';

class LessonScheduleVM extends ChangeNotifier {
  final LessonSchedule _schedule =
      GetIt.instance.get<UserManager>().currentUser.schedules.lessons;

  LessonScheduleVM() : super() {
    _schedule.addListener(_onScheduleStateChanged);
  }

  bool get isLoading => _schedule.isLoading;

  bool get isLoadingCompleted => _schedule.isLoadingCompleted;

  List<Lesson> get oddWeekMonday => _schedule.oddWeekMondayLessons;

  List<Lesson> get oddWeekTuesday => _schedule.oddWeekTuesdayLessons;

  List<Lesson> get oddWeekWednesday => _schedule.oddWeekWednesdayLessons;

  List<Lesson> get oddWeekThursday => _schedule.oddWeekThursdayLessons;

  List<Lesson> get oddWeekFriday => _schedule.oddWeekFridayLessons;

  List<Lesson> get oddWeekSaturday => _schedule.oddWeekSaturdayLessons;

  List<Lesson> get evenWeekMonday => _schedule.evenWeekMondayLessons;

  List<Lesson> get evenWeekTuesday => _schedule.evenWeekTuesdayLessons;

  List<Lesson> get evenWeekWednesday =>
      _schedule.evenWeekWednesdayLessons;

  List<Lesson> get evenWeekThursday => _schedule.evenWeekThursdayLessons;

  List<Lesson> get evenWeekFriday => _schedule.evenWeekFridayLessons;

  List<Lesson> get evenWeekSaturday => _schedule.evenWeekSaturdayLessons;

  List<Lesson> getLessonsByWeekTypeAndDayType(WeekType week, DayType day) =>
      _schedule.getLessonsByWeekTypeAndDayType(week, day);

  void _onScheduleStateChanged() {
    notifyListeners();
  }

  void onUpdateButtonClick() {
    _schedule.update();
  }

  @override
  void dispose() {
    _schedule.removeListener(_onScheduleStateChanged);
    super.dispose();
  }
}
