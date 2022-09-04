import 'package:flutter/cupertino.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';

import 'discipline.dart';
import 'teacher.dart';
import 'group.dart';
import 'class_room.dart';
import 'building.dart';

import './date.dart';

enum LessonType {
  practice,
  laboratoryWork,
  lecture,
}

class Lesson {
  final Discipline discipline;
  final List<LessonGroup> groups;
  final Teacher teacher;
  final LessonType lessonType;
  final ClassRoom classRoom;
  final Building building;
  final Date dateOfBegin;
  final Date dateOfEnd;
  final WeekType weekType;
  final DayType dayType;
  final int number;
  final int subgroupNumber;

  Lesson({
    required this.number,
    required this.discipline,
    required this.groups,
    required this.teacher,
    required this.lessonType,
    required this.building,
    required this.classRoom,
    required this.dateOfBegin,
    required this.dateOfEnd,
    required this.dayType,
    required this.weekType,
    required this.subgroupNumber
  });

  @override
  String toString() {
    return {
      'discipline': this.discipline.name,
      'groups': this.groups.map((e) => e.group.name) ,
      'subgroupNumber': subgroupNumber,
      'weekType' : this.weekType,
    }.toString();
  }
}

class LessonGroup {
  final Group group;
  final int subgroupNumber;

  LessonGroup({
    required this.group,
    required this.subgroupNumber
  });
}