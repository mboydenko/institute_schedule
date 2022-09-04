import '../../schedules/entities/student.dart';
import '../../schedules/models/student_schedules.dart';

import 'user.dart';

class UserStudent extends User {
  final Student student;

  UserStudent(this.student) : super(
    type: UserType.student,
    schedules: StudentSchedules(student)
  );


  @override
  String get name {
    if(student.group.numberOfSubgroups == 0) {
      return student.group.name;
    }
    return "${student.group.name} (${student.subgroupNumber} подгруппа)";
  }
}