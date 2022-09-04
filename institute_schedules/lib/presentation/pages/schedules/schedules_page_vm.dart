import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/constants/lesson_times.dart';
import 'package:institute_schedules/domain/schedules/entities/coursework.dart';
import 'package:institute_schedules/domain/schedules/entities/credit.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/exam.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/pre_exam_consultation.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/domain/schedules/exceptions/lesson_schedule_not_loaded_exception.dart';
import 'package:institute_schedules/domain/schedules/models/schedules.dart';
import 'package:institute_schedules/domain/users/models/user.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import 'package:institute_schedules/presentation/pages/lesson_details/lesson_details_page.dart';
import 'package:institute_schedules/presentation/pages/schedules/mappers/schedule_item_mapping.dart';
import 'package:institute_schedules/routing/router.gr.dart';
import './entities/schedule_item.dart';

class SchedulesVM extends ChangeNotifier {
  final BuildContext context;

  final UserManager _userManager =
      GetIt.instance.get<UserManager>();

  final Schedules _schedules =
      GetIt.instance.get<UserManager>().currentUser.schedules;

  final HashMap<ScheduleItem, Lesson> _lessons =
      HashMap<ScheduleItem, Lesson>();

  final HashMap<ScheduleItem, Exam> _exams = HashMap<ScheduleItem, Exam>();

  final HashMap<ScheduleItem, Credit> _credits =
      HashMap<ScheduleItem, Credit>();

  final HashMap<ScheduleItem, PreExamConsultation> _consultations =
      HashMap<ScheduleItem, PreExamConsultation>();

  final HashMap<ScheduleItem, Coursework> _courseWorks =
      HashMap<ScheduleItem, Coursework>();

  bool _showCalendar = false;

  int _currentIndex = 0;

  late Date _calendarDate;

  late Date _currentDate;

  late Date _dateIndex0;

  late Date _dateIndex1;

  late Date _dateIndex2;

  List<ScheduleItem> _scheduleIndex0 = [];

  List<ScheduleItem> _scheduleIndex1 = [];

  List<ScheduleItem> _scheduleIndex2 = [];

  bool get showCalender => _showCalendar;

  SchedulesVM(this.context) {
    var today = DateTime.now();

    _currentDate = Date(day: today.day, month: today.month, year: today.year);

    _calendarDate = _currentDate;

    _currentIndex = 0;

    _dateIndex0 = _currentDate;

    _updateDates();

    _updateSchedule();

    _schedules.addListener(_onSchedulesStateUpdated);
  }

  // PUBLIC METHODS

  @override
  void dispose() {
    _schedules.removeListener(_onSchedulesStateUpdated);
    super.dispose();
  }

  void onUpdateButtonClick() {
    _schedules.update();
  }

  bool get isLoading => _schedules.isLoading;

  bool get isLoadingCompleted => _schedules.isLoadingCompleted;

  WeekType get weekType => Week.getWeekTypeByDate(_currentDate);

  String get title => _userManager.currentUser.name;

  UserType get userType => _userManager.currentUser.type;

  void onCarouselChanged(int index) {
    if (index > _currentIndex) {
      if (_currentIndex == 0 && index == 2) {
        _moveBack();
      } else {
        _moveForward();
      }
    } else {
      if (_currentIndex == 2 && index == 0) {
        _moveForward();
      } else {
        _moveBack();
      }
    }
  }

  void selectDate(Date date) {
    _currentDate = date;

    _updateDates();

    _updateSchedule();

    notifyListeners();
  }

  Date get selectedDate => _currentDate;

  Date get calendarSelectedDate => _calendarDate;

  int get currentIndex => _currentIndex;

  List<ScheduleItem> get scheduleIndex0 => [..._scheduleIndex0];

  List<ScheduleItem> get scheduleIndex1 => [..._scheduleIndex1];

  List<ScheduleItem> get scheduleIndex2 => [..._scheduleIndex2];

  Date get dateIndex0 => _dateIndex0;

  Date get dateIndex1 => _dateIndex1;

  Date get dateIndex2 => _dateIndex2;

  // PRIVATE METHODS

  void _updateSchedule() {
    _clearAllScheduleItems();

    try {
      _scheduleIndex0 = _loadAndSaveScheduleByDate(_dateIndex0);

      _scheduleIndex1 = _loadAndSaveScheduleByDate(_dateIndex1);

      _scheduleIndex2 = _loadAndSaveScheduleByDate(_dateIndex2);
    } on LessonScheduleNotLoadedException catch (e) {
      _scheduleIndex0 = [];

      _scheduleIndex1 = [];

      _scheduleIndex2 = [];
    }
  }

  void _moveForward() {
    if (_currentIndex == 2) {
      _currentIndex = 0;
    } else {
      _currentIndex++;
    }

    var nextDate = _currentDate.toDateTime.add(const Duration(days: 1));

    _currentDate =
        Date(day: nextDate.day, month: nextDate.month, year: nextDate.year);

    _updateDates();

    _updateSchedule();

    notifyListeners();
  }

  void _moveBack() {
    if (_currentIndex == 0) {
      _currentIndex = 2;
    } else {
      _currentIndex--;
    }

    var previousDate = _currentDate.toDateTime.add(const Duration(days: -1));

    _currentDate = Date(
        day: previousDate.day,
        month: previousDate.month,
        year: previousDate.year);

    _updateDates();

    _updateSchedule();

    notifyListeners();
  }

  void _updateDates() {
    var currentDate = _currentDate.toDateTime;

    _calendarDate = _currentDate;

    var previousDate = currentDate.add(const Duration(days: -1));

    var nextDate = currentDate.add(const Duration(days: 1));

    if (_currentIndex == 0) {
      _dateIndex0 = Date(
          day: currentDate.day,
          month: currentDate.month,
          year: currentDate.year);

      // Next date
      _dateIndex1 =
          Date(day: nextDate.day, month: nextDate.month, year: nextDate.year);

      // Previous date
      _dateIndex2 = Date(
          day: previousDate.day,
          month: previousDate.month,
          year: previousDate.year);
    } else if (_currentIndex == 1) {
      _dateIndex0 = Date(
          day: previousDate.day,
          month: previousDate.month,
          year: previousDate.year);

      // Next date
      _dateIndex1 = Date(
          day: currentDate.day,
          month: currentDate.month,
          year: currentDate.year);

      // Previous date
      _dateIndex2 =
          Date(day: nextDate.day, month: nextDate.month, year: nextDate.year);

      // _currentIndex will be 2
    } else {
      _dateIndex0 =
          Date(day: nextDate.day, month: nextDate.month, year: nextDate.year);

      // Next date
      _dateIndex1 = Date(
          day: previousDate.day,
          month: previousDate.month,
          year: previousDate.year);

      // Previous date
      _dateIndex2 = Date(
          day: currentDate.day,
          month: currentDate.month,
          year: currentDate.year);
    }
  }

  void _clearAllScheduleItems() {
    _exams.clear();
    _lessons.clear();
    _consultations.clear();
    _courseWorks.clear();
  }

  List<ScheduleItem> _loadAndSaveScheduleByDate(Date date) {
    List<ScheduleItem> items = [];

    var lessons = _schedules.lessons.getLessonByDate(date);

    for (var lesson in lessons) {
      ScheduleItem scheduleItem;

      switch (lesson.number) {
        case 1:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_1_START_TIME, LESSON_1_END_TIME);
          break;
        case 2:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_2_START_TIME, LESSON_2_END_TIME);
          break;
        case 3:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_3_START_TIME, LESSON_3_END_TIME);
          break;
        case 4:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_4_START_TIME, LESSON_4_END_TIME);
          break;
        case 5:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_5_START_TIME, LESSON_5_END_TIME);
          break;
        case 6:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_6_START_TIME, LESSON_6_END_TIME);
          break;
        case 7:
          scheduleItem = ScheduleItemMapping.fromLesson(
              lesson, LESSON_7_START_TIME, LESSON_7_END_TIME);
          break;
        default:
          throw Exception("Invalid data");
      }
      _lessons.addAll({scheduleItem: lesson});

      items.add(scheduleItem);
    }

    var exams = _schedules.exams.getExamsByDate(date);

    for (var exam in exams) {
      ScheduleItem item = ScheduleItemMapping.fromExam(exam);

      _exams.addAll({item: exam});

      items.add(item);
    }

    var credits = _schedules.credits.getCreditsByDate(date);

    for (var credit in credits) {
      ScheduleItem item = ScheduleItemMapping.fromCredit(credit);

      _credits.addAll({item: credit});

      items.add(item);
    }

    var courseworks = _schedules.courseworks.getCourseWorksByDate(date);

    for (var coursework in courseworks) {
      ScheduleItem item = ScheduleItemMapping.fromCoursework(coursework);
      items.add(item);
    }

    items.sort((item1, item2) {
      return (item1.startTime.hours * 60 + item1.startTime.minutes)
          .compareTo(item2.startTime.hours * 60 + item2.startTime.minutes);
    });

    return items;
  }

  void _onSchedulesStateUpdated() {
    notifyListeners();
    if (_schedules.isLoadingCompleted) {
      _updateSchedule();
      notifyListeners();
    }
  }

  void onCalendarDateButtonClick(DateTime dt) {
    _calendarDate = Date(
      day: dt.day,
      month: dt.month,
      year: dt.year
    );
    notifyListeners();
  }

  void onCalendarOkButtonClick() {
    selectDate(_calendarDate);
    _showCalendar = false;

    notifyListeners();
  }

  void onCalendarCancelButtonClick() {
    _calendarDate = _currentDate;
    _showCalendar = false;
    notifyListeners();
  }

  void onCalenderButtonClick() {
    _showCalendar = true;
    notifyListeners();
  }

  void onScheduleItemClick(ScheduleItem item) {
    switch(item.type) {
      case ScheduleItemType.practice:
        var lesson = _lessons[item] as Lesson;
        context.router.push(LessonDetailsRoute(lesson: lesson));
        break;
      case ScheduleItemType.laboratoryWork:
        var lesson = _lessons[item] as Lesson;
        context.router.push(LessonDetailsRoute(lesson: lesson));
        break;
      case ScheduleItemType.lecture:
        var lesson = _lessons[item] as Lesson;
        context.router.push(LessonDetailsRoute(lesson: lesson));
        break;
      case ScheduleItemType.exam:
        // TODO: Handle this case.
        break;
      case ScheduleItemType.credit:
        // TODO: Handle this case.
        break;
      case ScheduleItemType.consultation:
        // TODO: Handle this case.
        break;
      case ScheduleItemType.coursework:
        // TODO: Handle this case.
        break;
    }
  }
}
