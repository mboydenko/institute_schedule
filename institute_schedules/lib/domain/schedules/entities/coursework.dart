import 'building.dart';
import 'class_room.dart';
import 'group.dart';
import 'teacher.dart';
import 'date.dart';
import 'discipline.dart';
import 'time.dart';

class Coursework {
  final int id;
  final List<Teacher> commissionComposition;
  final Date date;
  final Time time;
  final Discipline discipline;
  final Group group;
  final Building building;
  final ClassRoom classRoom;

  Coursework(
      {required this.id,
      required this.commissionComposition,
      required this.group,
      required this.discipline,
      required this.time,
      required this.date,
      required this.building,
      required this.classRoom});
}
