import '../../entities/credit.dart';
import '../../entities/student.dart';

import 'credit_schedule.dart';

class StudentCreditSchedule extends CreditSchedule {
  final Student student;

  StudentCreditSchedule({required this.student}) : super();

  @override
  Future<List<Credit>> load() async {
    final groupCredits = await creditRepository.getCreditsByGroupId(student.group.id);
    final subgroupCredits = <Credit>[];
    for(var credit in groupCredits) {
      if(credit.subgroupNumber == 0 || credit.subgroupNumber == student.subgroupNumber) {
        subgroupCredits.add((credit));
      }
    }
    return subgroupCredits;
  }
}
