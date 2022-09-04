import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/presentation/widgets/schedule_item_type_widget.dart';

class LessonWidget extends StatelessWidget {
  final Lesson lesson;

  const LessonWidget({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                      children: [
                    _LessonTypeWidget(lessonType: lesson.lessonType),
                  ]),
                  const SizedBox(height: 8),
                  _LessonTitle(title: lesson.discipline.name),
                  const SizedBox(height: 8),
                  _Label(labelName: "Преподаватель", text: lesson.teacher.lastNameWithInitials),
                  const SizedBox(height: 8),
                  _Label(labelName: "Корпус", text: lesson.building.shortName),
                  const SizedBox(height: 8),
                  _Label(labelName: "Аудитория", text: lesson.classRoom.name),
                  const SizedBox(height: 8),
                  _Date(begin: lesson.dateOfBegin, end: lesson.dateOfEnd)
                ],
              )
          ),
          const SizedBox(width: 30),
          const _DetailsWidget()
        ],
      )
    );
  }
}

class _LessonTypeWidget extends StatelessWidget {
  final LessonType lessonType;

  const _LessonTypeWidget({Key? key, required this.lessonType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(lessonType){
      case LessonType.practice:
        return const PracticeTypeWidget();
      case LessonType.laboratoryWork:
        return const LaboratoryTypeWorkWidget();
      case LessonType.lecture:
        return const LectureTypeWidget();
    }
  }

}

class _LessonTitle extends StatelessWidget {
  final String title;

  const _LessonTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        color: Colors.red
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String labelName;
  final String text;

  const _Label({Key? key, required this.labelName, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$labelName:", style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 102, 255, 1)
        )),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black
          ),
        )
      ],
    );
  }
}

class _Date extends StatelessWidget {
  final Date begin;

  final Date end;

  const _Date({Key? key, required this.begin, required this.end}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result;

    if(begin.year == end.year && begin.day == end.day && begin.month == end.month) {
      result = begin.toString();
    }else {
      result = "${begin.toString()} - ${end.toString()}";
    }
    return _Label(labelName: "Дата", text: result);
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_right_sharp, color: Colors.black);
  }
}