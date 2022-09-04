import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/constants/lesson_times.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/presentation/widgets/schedule_item_type_widget.dart';
import 'package:auto_route/auto_route.dart';

class LessonDetailsPage extends StatelessWidget {
  final Lesson lesson;
  const LessonDetailsPage({Key? key, required this.lesson}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Детали пары"),
        leading: BackButton(onPressed: () => context.popRoute()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              _LessonDetailsWidget(lesson: lesson, number: lesson.number)
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonTypeWidget extends StatelessWidget {
  final LessonType lessonType;
  const _LessonTypeWidget({Key? key, required this.lessonType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (lessonType) {
      case LessonType.laboratoryWork:
        return const LaboratoryTypeWorkWidget();
      case LessonType.lecture:
        return const LectureTypeWidget();
      case LessonType.practice:
        return const PracticeTypeWidget();
    }
  }
}

class _LessonDetailsWidget extends StatelessWidget {
  final int number;

  final Lesson lesson;

  const _LessonDetailsWidget(
      {Key? key, required this.lesson, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Time startTime;

    Time endTime;

    switch (number) {
      case 1:
        startTime = LESSON_1_START_TIME;
        endTime = LESSON_1_END_TIME;
        break;
      case 2:
        startTime = LESSON_2_START_TIME;
        endTime = LESSON_2_END_TIME;
        break;
      case 3:
        startTime = LESSON_3_START_TIME;
        endTime = LESSON_3_END_TIME;
        break;
      case 4:
        startTime = LESSON_4_START_TIME;
        endTime = LESSON_4_END_TIME;
        break;
      case 5:
        startTime = LESSON_5_START_TIME;
        endTime = LESSON_5_END_TIME;
        break;
      case 6:
        startTime = LESSON_6_START_TIME;
        endTime = LESSON_6_END_TIME;
        break;
      case 7:
        startTime = LESSON_7_START_TIME;
        endTime = LESSON_7_END_TIME;
        break;
      default:
        throw Exception("Invalid number");
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        SizedBox(
          height: 50,
          child: Center(
            child: _TimeWidget(
              endTime: endTime,
              startTime: startTime,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _LessonTypeWidget(lessonType: lesson.lessonType),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Дисциплина:",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              lesson.discipline.name,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Преподаватель:",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${lesson.teacher.lastName} ${lesson.teacher.firstName} ${lesson.teacher.middleName}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              lesson.groups.length == 1 ? "Группа:" : "Группы:",
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            _GroupsList(groups: lesson.groups),
            const SizedBox(height: 10),
            const Text("Корпус:",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 10),
            Text(
              lesson.building.name,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text("Аудитория:",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 10),
            Text(
              lesson.classRoom.name,
              style: const TextStyle(fontSize: 16),
            )
          ]),
        ),
      ]),
    );
  }
}

class _TimeWidget extends StatelessWidget {
  final Time startTime;

  final Time endTime;

  const _TimeWidget({Key? key, required this.startTime, required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startTimeMinutes = startTime.minutes > 9
        ? startTime.minutes.toString()
        : "0${startTime.minutes}";

    final endTimeMinutes = endTime.minutes > 9
        ? endTime.minutes.toString()
        : "0${endTime.minutes}";

    final _startTime = "${startTime.hours}:$startTimeMinutes";

    final _endTime = "${endTime.hours}:$endTimeMinutes";

    return Text("$_startTime - $_endTime",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ));
  }
}

class _GroupsList extends StatelessWidget {
  final List<LessonGroup> groups;

  const _GroupsList({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String value = "";

    for(var lessonGroup in groups) {
      if(lessonGroup != groups.last) {
        if(lessonGroup.subgroupNumber == 0) {
          value += "${lessonGroup.group.name}, ";
        } else {
          value += "${lessonGroup.group.name} (${lessonGroup.subgroupNumber} подгруппа), ";
        }
      } else {
        if(lessonGroup.subgroupNumber == 0) {
          value += lessonGroup.group.name;
        } else {
          value += "${lessonGroup.group.name} (${lessonGroup.subgroupNumber} подгруппа)";
        }
      }
    }

    return Text(value, style: const TextStyle(fontSize: 16));
  }
}
