import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher_consultation.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_consultation_repository.dart';

class TeacherInformationVM with ChangeNotifier {
  final TeacherConsultationRepository _teacherConsultationRepository =
      GetIt.instance.get<TeacherConsultationRepository>();

  final Teacher teacher;

  bool _loading = false;

  bool _loadingCompleted = false;

  List<TeacherConsultation> _teacherConsultations = [];

  TeacherInformationVM({required this.teacher}) {
    loadConsultationSchedule();
  }

  bool get isConsultationsScheduleLoading => _loading;

  bool get isConsultationLoadingCompleted => _loadingCompleted;

  List<TeacherConsultation> get teacherConsultations => [..._teacherConsultations];

  void onUpdateButtonClicked() {
    loadConsultationSchedule();
  }

  void loadConsultationSchedule() {
    _loading = true;

    _loadingCompleted = false;

    notifyListeners();

    _teacherConsultationRepository
        .getTeacherConsultationsById(teacher.id)
        .then((consultations) {
          _teacherConsultations = [...consultations];
          _loading = false;
          _loadingCompleted = true;
          notifyListeners();
    }).catchError((error){
      Fluttertoast.showToast(
          msg: "Возникла ошибка, проверте соединение с интернетом",
          fontSize: 14,
          gravity: ToastGravity.BOTTOM
      );
      _teacherConsultations.clear();
      _loading = false;
      _loadingCompleted =true;
      notifyListeners();
    });
  }

  List<TeacherConsultation> get oddWeekConsultations {
    List<TeacherConsultation> result = [];
    for(var consultation in _teacherConsultations) {
      if(consultation.weekType == WeekType.odd || consultation.weekType == WeekType.both) {
        result.add(consultation);
      }
    }
    return result;
  }

  List<TeacherConsultation> get evenWeekConsultations {
    List<TeacherConsultation> result = [];
    for(var consultation in _teacherConsultations) {
      if(consultation.weekType == WeekType.even || consultation.weekType == WeekType.both) {
        result.add(consultation);
      }
    }
    return result;
  }
}
