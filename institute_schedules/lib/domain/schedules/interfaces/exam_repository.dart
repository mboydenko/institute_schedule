import '../entities/exam.dart';

abstract class ExamRepository {
  Future<List<Exam>> getExamsByTeacherId(int id);

  Future<List<Exam>> getExamsByGroupId(int id);
}
