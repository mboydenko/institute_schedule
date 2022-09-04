import 'building.dart';
import 'class_room.dart';
import 'group.dart';
import 'teacher.dart';
import 'discipline.dart';
import 'time.dart';

enum ScheduleItemType {
  practice,
  laboratoryWork,
  lecture,
  exam,
  credit,
  consultation,
  coursework
}

class ScheduleItem {
  final ScheduleItemType type;
  final Time startTime;
  final Time? endTime;
  final Discipline discipline;
  final List<Group> groups;
  final List<Teacher> teachers;
  final Building building;
  final ClassRoom classRoom;

  ScheduleItem(
      {required this.type,
      required this.startTime,
      this.endTime,
      required this.discipline,
      required this.groups,
      required this.teachers,
      required this.building,
      required this.classRoom});
}
