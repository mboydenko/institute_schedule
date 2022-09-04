import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_repository.dart';
import 'package:institute_schedules/tools/debounce.dart';

class TeacherSelectionVM extends ChangeNotifier {
  final TeacherRepository _teacherRepository =
      GetIt.instance.get<TeacherRepository>();

  Debounce _debounce = Debounce();

  bool _loading = false;

  bool _loadingCompleted = false;

  String _value = "";

  List<Teacher> _teachers = [];

  List<Teacher> get teachers => [..._teachers];

  void onFieldChanged(String value) {
    if (_value == value.trim()) {
      return;
    }

    _debounce.cancel();

    _value = value.trim();

    if (_value.isNotEmpty) {
      _loading = true;

      _loadingCompleted = false;

      notifyListeners();

      _debounce.start(
          const Duration(seconds: 1),
          () => {
                _teacherRepository
                    .getTeachersByPathOfName(_value)
                    .then((teachers) {

                  if (_value.isEmpty) {
                    _loading = false;

                    _loadingCompleted = false;

                    _teachers.clear();

                    notifyListeners();

                    return;
                  }

                  _teachers = [...teachers];

                  _loading = false;

                  _loadingCompleted = true;

                  notifyListeners();
                }).catchError((error){
                  Fluttertoast.showToast(
                      msg: "Возникла ошибка, проверте соединение с интернетом",
                      fontSize: 14,
                      gravity: ToastGravity.BOTTOM
                  );
                  _teachers.clear();
                  _loading = false;
                  _loadingCompleted =true;
                  notifyListeners();
                })
              });
    } else {
      _loading = false;

      _loadingCompleted = false;

      _teachers.clear();

      notifyListeners();
    }
  }

  bool get isLoading => _loading;

  bool get isLoadingCompleted => _loadingCompleted;
}
