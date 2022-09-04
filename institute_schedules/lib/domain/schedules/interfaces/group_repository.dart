import '../entities/group.dart';

abstract class GroupRepository {
  Future<List<Group>> getGroupsByPathOfName(String pathOfName);

  Future<Group> getGroupById(int id);
}
