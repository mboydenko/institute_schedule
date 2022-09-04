import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/domain/schedules/models/courseworks/coursework_schedule.dart';
import 'package:institute_schedules/domain/schedules/models/schedules.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import '../../../domain/schedules/entities/coursework.dart';


class CourseworkScheduleVM extends ChangeNotifier {
  BuildContext context;

  final CourseworkSchedule _schedule =
      GetIt.instance.get<UserManager>().currentUser.schedules.courseworks;

  CourseworkScheduleVM(this.context) : super() {
    _schedule.addListener(_onCourseworkScheduleStateChanged);
  }

  bool get isLoading => _schedule.isLoading;

  bool get isLoadingCompleted => _schedule.isLoadingCompleted;

  List<Coursework> get coursworks => [..._schedule.courseworks];

  void onUpdateButtonClick() {
    _schedule.update();
  }

  @override
  void dispose() {
    _schedule.removeListener(_onCourseworkScheduleStateChanged);
    super.dispose();
  }

  void _onCourseworkScheduleStateChanged() {
    notifyListeners();
  }

  void onBackButtonClick() {
    context.popRoute();
  }
}
