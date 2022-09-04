

import 'package:institute_schedules/domain/schedules/entities/group.dart';

class GroupWrapper {
  final Group group;
  final int subgroupNumber;
  GroupWrapper({
    required this.group,
    this.subgroupNumber = 0
  });

  String get name  {
    if(subgroupNumber > 0) {
      return "${group.name} ($subgroupNumber подгруппа)";
    }
    return group.name;
  }
}