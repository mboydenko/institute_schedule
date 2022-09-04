import 'building.dart';
import 'class_room.dart';
import 'group.dart';
import 'teacher.dart';
import 'date.dart';
import 'discipline.dart';
import 'time.dart';

class Credit {
  final int id;
  final Teacher teacher;
  final Date date;
  final Time time;
  final Discipline discipline;
  final Building building;
  final ClassRoom classRoom;
  final Group group;
  final int subgroupNumber;

  Credit(
      {required this.id,
      required this.teacher,
      required this.group,
      required this.date,
      required this.time,
      required this.discipline,
      required this.building,
      required this.classRoom,
      required this.subgroupNumber
    });
}
