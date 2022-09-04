import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/discipline.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';

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
  final List<ScheduleItemGroup> groups;
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

class ScheduleItemGroup {
  Group group;
  int subgroupNumber;

  ScheduleItemGroup({
    required this.group,
    required this.subgroupNumber
  });
}