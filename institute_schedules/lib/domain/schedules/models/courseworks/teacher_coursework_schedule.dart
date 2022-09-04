import 'package:institute_schedules/domain/schedules/entities/teacher.dart';

import '../../entities/coursework.dart';

import 'coursework_schedule.dart';

class TeacherCourseworkSchedule extends CourseworkSchedule {
  final Teacher teacher;

  TeacherCourseworkSchedule({required this.teacher}) : super();

  @override
  Future<List<Coursework>> load() {
    return courseworkRepository.getCourseWorksByTeacherId(teacher.id);
  }
}
