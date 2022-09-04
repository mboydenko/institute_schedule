import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/credit.dart';
import 'package:institute_schedules/domain/schedules/models/credits/credit_schedule.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';

class CreditScheduleVM extends ChangeNotifier {
  final CreditSchedule _schedule =
      GetIt.instance.get<UserManager>().currentUser.schedules.credits;

  CreditScheduleVM() : super() {
    _schedule.addListener(_onCreditScheduleStateChanged);
  }

  bool get isLoading => _schedule.isLoading;

  bool get isLoadingCompleted => _schedule.isLoadingCompleted;

  List<Credit> get credits => [..._schedule.credits];

  void onUpdateButtonClicked() {
    _schedule.update();
  }

  @override
  void dispose() {
    _schedule.removeListener(_onCreditScheduleStateChanged);
    super.dispose();
  }

  void _onCreditScheduleStateChanged() {
    notifyListeners();
  }
}
