import '../../entities/coursework.dart';
import '../../entities/student.dart';

import 'coursework_schedule.dart';

class StudentCourseworkSchedule extends CourseworkSchedule {
  final Student student;

  StudentCourseworkSchedule({
    required this.student,
  }) : super();

  @override
  Future<List<Coursework>> load() {
    return courseworkRepository.getCourseWorksByGroupId(student.group.id);
  }
}
