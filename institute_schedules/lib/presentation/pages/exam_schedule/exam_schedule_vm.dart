import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/exam.dart';
import 'package:institute_schedules/domain/schedules/models/exams/exam_schedule.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';

class ExamScheduleVM extends ChangeNotifier {
  final ExamSchedule _schedule =
      GetIt.instance.get<UserManager>().currentUser.schedules.exams;

  ExamScheduleVM() : super() {
    _schedule.addListener(_onExamScheduleStateChanged);
  }

  bool get isLoading => _schedule.loading;

  bool get isLoadingCompleted => _schedule.loadingCompleted;

  List<Exam> get exams => _schedule.exams;

  void onUpdateButtonClicked() {
    _schedule.update();
  }

  void _onExamScheduleStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _schedule.removeListener(_onExamScheduleStateChanged);
    super.dispose();
  }
}
