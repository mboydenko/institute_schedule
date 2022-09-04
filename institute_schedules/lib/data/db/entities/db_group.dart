
import 'package:hive/hive.dart';

part 'db_group.g.dart';

@HiveType(typeId: 1, adapterName: "GroupAdapter")
class DbGroup {
  DbGroup({required this.name, required this.numberOfSubgroups});

  @HiveField(0)
  String name;

  @HiveField(1)
  int numberOfSubgroups;

  @override
  String toString() {
    return "$name";
  }
}