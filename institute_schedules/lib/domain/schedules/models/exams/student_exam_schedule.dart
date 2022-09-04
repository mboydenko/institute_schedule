

import '../../entities/exam.dart';
import '../../entities/student.dart';

import './exam_schedule.dart';

class StudentExamSchedule extends ExamSchedule {
  final Student student;

  StudentExamSchedule({required this.student}) : super();

  @override
  Future<List<Exam>> load() async {
    return examRepository.getExamsByGroupId(student.group.id);
  }
}
