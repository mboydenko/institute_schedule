import 'building.dart';
import 'class_room.dart';
import 'group.dart';
import 'teacher.dart';

import '../entities/discipline.dart';
import './date.dart';
import './discipline.dart';
import './time.dart';

enum ExamType {
  exam,
  consultation
}

class Exam {
  final int id;
  final Discipline discipline;
  final Date date;
  final Time time;
  final List<Group> groups;
  final Teacher teacher;
  final Building building;
  final ClassRoom classRoom;
  final ExamType type;

  Exam(
      {this.id = 0,
      required this.discipline,
      required this.groups,
      required this.teacher,
      required this.time,
      required this.date,
      required this.classRoom,
      required this.building,
      required this.type
  });
}
