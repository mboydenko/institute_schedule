import '../../entities/exam.dart';
import '../../entities/teacher.dart';

import './exam_schedule.dart';

class TeacherExamSchedule extends ExamSchedule{
  final Teacher teacher;

  TeacherExamSchedule({
    required this.teacher,
  }) : super();

  @override
  Future<List<Exam>> load() async {
    return await examRepository.getExamsByTeacherId(teacher.id);
  }
}
