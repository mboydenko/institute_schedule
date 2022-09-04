import '../../schedules/entities/teacher.dart';
import '../../schedules/models/teacher_schedules.dart';

import 'user.dart';

class UserTeacher extends User {
  final Teacher teacher;

  UserTeacher(this.teacher) : super(
      schedules: TeacherSchedules(teacher),
      type: UserType.teacher
  );

  @override
  String get name => teacher.lastNameWithInitials;

}