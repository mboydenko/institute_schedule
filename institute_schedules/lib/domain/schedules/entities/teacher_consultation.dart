import '../entities/week.dart';

import 'building.dart';
import 'class_room.dart';
import 'teacher.dart';

import 'time.dart';
import 'day.dart';


class TeacherConsultation {

  final int id;

  final Time time;

  final String name;

  final DayType day;

  // final Teacher teacher;

  final Building? building;

  final ClassRoom? cabinet;

  final WeekType weekType;

  final DayType weekDay;

  TeacherConsultation(
      {required this.id,
      required this.name,
      required this.day,
      required this.time,
      // required this.teacher,
      required this.weekType,
      required this.weekDay,
      this.building,
      this.cabinet});
}
