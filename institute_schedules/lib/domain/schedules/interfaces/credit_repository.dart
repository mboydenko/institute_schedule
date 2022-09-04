import '../entities/credit.dart';

abstract class CreditRepository {
  Future<List<Credit>> getCreditsByGroupId(int id);

  Future<List<Credit>> getCreditsByTeacherId(int id);
}