import '../entities/teacher_consultation.dart';

abstract class TeacherConsultationRepository {
  Future<List<TeacherConsultation>> getTeacherConsultationsById(int teacherId);
}
