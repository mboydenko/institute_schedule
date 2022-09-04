import '../../entities/credit.dart';
import '../../entities/teacher.dart';

import 'credit_schedule.dart';

class TeacherCreditSchedule extends CreditSchedule {
  final Teacher teacher;

  TeacherCreditSchedule({required this.teacher});

  @override
  Future<List<Credit>> load() {
    return creditRepository.getCreditsByTeacherId(teacher.id);
  }
}
