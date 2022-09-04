import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/constants/lesson_times.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';
import '../lesson_schedule_vm.dart';
import 'lesson_widget.dart';

class DaySchedule extends StatelessWidget {
  final DayType dayType;

  final WeekType weekType;

  const DaySchedule({Key? key, required this.dayType, required this.weekType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LessonScheduleVM>(context);

    List<Lesson> lessons =
        model.getLessonsByWeekTypeAndDayType(weekType, dayType);

    if(kDebugMode) {
      print("Day schedule widget");
      print(lessons);
    }

    return CardWidget(
        title: getDayTitle(dayType),
        body: model.isLoadingCompleted
            ? _ScheduleBody(
                lesson1List: getLesson1List(lessons),
                lesson2List: getLesson2List(lessons),
                lesson3List: getLesson3List(lessons),
                lesson4List: getLesson4List(lessons),
                lesson5List: getLesson5List(lessons),
                lesson6List: getLesson6List(lessons),
                lesson7List: getLesson7List(lessons),
              )
            : _ScheduleLoading());
  }

  String getDayTitle(DayType dayType) {
    switch (dayType) {
      case DayType.monday:
        return "ПОНЕДЕЛЬНИК";
      case DayType.tuesday:
        return "ВТОРНИК";
      case DayType.wednesday:
        return "СРЕДА";
      case DayType.thursday:
        return "ЧЕТВЕРГ";
      case DayType.friday:
        return "ПЯТНИЦА";
      case DayType.saturday:
        return "СУББОТА";
    }
  }

  List<Lesson> getLesson1List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 1) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> getLesson2List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 2) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> getLesson3List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 3) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> getLesson4List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 4) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> getLesson5List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 5) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> getLesson6List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 6) {
        result.add(lesson);
      }
    }
    return result;
  }

  List<Lesson> getLesson7List(List<Lesson> lessons) {
    var result = <Lesson>[];
    for (var lesson in lessons) {
      if (lesson.number == 7) {
        result.add(lesson);
      }
    }
    return result;
  }
}

class _ScheduleLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      child: Center(
          child: SpinnerWithLabelWidget(
        text: "Загрузка расписания",
        layout: SpinnerWithLabelWidgetLayout.spinnerTop,
        textStyle: TextStyle(fontSize: 18, color: Colors.white),
      )),
    );
  }
}

class _ScheduleBody extends StatelessWidget {
  final List<Lesson> lesson1List;
  final List<Lesson> lesson2List;
  final List<Lesson> lesson3List;
  final List<Lesson> lesson4List;
  final List<Lesson> lesson5List;
  final List<Lesson> lesson6List;
  final List<Lesson> lesson7List;

  const _ScheduleBody(
      {Key? key,
      required this.lesson1List,
      required this.lesson2List,
      required this.lesson3List,
      required this.lesson4List,
      required this.lesson5List,
      required this.lesson6List,
      required this.lesson7List})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "1. $LESSON_1_START_TIME - $LESSON_1_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson1List.isNotEmpty
            ? lessonWidgets(lesson1List)
            : [_NoLessons()],
      ),
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "2. $LESSON_2_START_TIME - $LESSON_2_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson2List.isNotEmpty
            ? lessonWidgets(lesson2List)
            : [_NoLessons()],
      ),
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "3. $LESSON_3_START_TIME - $LESSON_3_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson3List.isNotEmpty
            ? lessonWidgets(lesson3List)
            : [_NoLessons()],
      ),
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "4. $LESSON_4_START_TIME - $LESSON_4_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson4List.isNotEmpty
            ? lessonWidgets(lesson4List)
            : [_NoLessons()],
      ),
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "5. $LESSON_5_START_TIME - $LESSON_5_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson5List.isNotEmpty
            ? lessonWidgets(lesson5List)
            : [_NoLessons()],
      ),
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "6. $LESSON_6_START_TIME - $LESSON_6_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson6List.isNotEmpty
            ? lessonWidgets(lesson6List)
            : [_NoLessons()],
      ),
      ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "7. $LESSON_7_START_TIME - $LESSON_7_END_TIME",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: lesson7List.isNotEmpty
            ? lessonWidgets(lesson7List)
            : [_NoLessons()],
      ),
    ]);
  }

  List<Widget> lessonWidgets(List<Lesson> lessons) {
    var widgets = <Widget>[];
    for (var lesson in lessons) {
      widgets.add(LessonWidget(lesson: lesson));
      if (lesson != lessons.last) {
        widgets.add(Container(color: Colors.blue, height: 1));
      }
    }
    return widgets;
  }
}

class _NoLessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      child: const Center(
        child: Text('Нет занятий'),
      ),
    );
  }
}
