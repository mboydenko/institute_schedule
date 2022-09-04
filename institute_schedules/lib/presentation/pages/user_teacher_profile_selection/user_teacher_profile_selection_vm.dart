import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_repository.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import 'package:institute_schedules/routing/router.gr.dart';
import 'package:institute_schedules/tools/debounce.dart';
import 'package:auto_route/auto_route.dart';

class UserTeacherProfileSelectionVM extends ChangeNotifier {
  final BuildContext context;

  final _teacherRepository = GetIt.instance.get<TeacherRepository>();

  final _userManager = GetIt.instance.get<UserManager>();

  String _fieldValue = "";

  bool _loading = false;

  bool _loadingCompleted = false;

  final Debounce _debounce = Debounce();

  bool get isLoading => _loading;

  bool get isLoadingCompleted => _loadingCompleted;

  List<Teacher> _searchResult = [];

  UserTeacherProfileSelectionVM(this.context) : super();

  List<Teacher> get searchResult => [..._searchResult];

  void onFieldChanged(String value) {
    if (_fieldValue == value.trim()) {
      return;
    }

    _debounce.cancel();

    _fieldValue = value.trim();

    if (_fieldValue.isNotEmpty) {
      _loading = true;

      _loadingCompleted = false;

      notifyListeners();

      _debounce.start(
          const Duration(seconds: 1),
              () => {
            _teacherRepository
                .getTeachersByPathOfName(_fieldValue)
                .then((teachers) {

              if (_fieldValue.isEmpty) {
                _loading = false;

                _loadingCompleted = false;

                _searchResult.clear();

                notifyListeners();

                return;
              }

              _searchResult = [...teachers];

              _loading = false;

              _loadingCompleted = true;

              notifyListeners();
            })
            .catchError((error) {
              Fluttertoast.showToast(
                msg: "Возникла ошибка, проверте соединение с интернетом",
                fontSize: 14,
                gravity: ToastGravity.BOTTOM
              );
              _searchResult = [];
              _loadingCompleted = false;
              _loading = false;
              notifyListeners();
            })
          });
    } else {
      _loading = false;

      _loadingCompleted = false;

      _searchResult.clear();

      notifyListeners();
    }
  }

  void onTeacherClick(Teacher teacher) {
    _userManager.switchToTeacher(teacher);
    context.router.replaceAll([const HomeRoute()]);
  }
}

