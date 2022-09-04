import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/domain/schedules/entities/student.dart';
import 'package:institute_schedules/domain/schedules/interfaces/group_repository.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import 'package:institute_schedules/presentation/pages/user_student_profile_selection/entities/group_wrapper.dart';
import 'package:institute_schedules/routing/router.gr.dart';
import 'package:institute_schedules/tools/debounce.dart';

class UserStudentProfileSelectionVM extends ChangeNotifier {
  final BuildContext context;

  final _groupRepository = GetIt.instance.get<GroupRepository>();

  final _userManager = GetIt.instance.get<UserManager>();

  bool _loading = false;

  bool _loadingCompleted = false;

  List<GroupWrapper> _searchResult = [];

  String _fieldValue = "";

  final Debounce _debounce = Debounce();

  UserStudentProfileSelectionVM(this.context) : super();

  bool get isLoading => _loading;

  bool get isLoadingCompleted => _loadingCompleted;

  List<GroupWrapper> get searchResult => _searchResult;

  void onFieldChanged(String value) {
    if (_fieldValue == value.trim()) {
      return;
    }

    _debounce.cancel();

    _fieldValue = value.trim();

    if (_fieldValue.isNotEmpty) {
      _loading = true;

      _loadingCompleted = false;

      _searchResult = [];

      notifyListeners();

      _debounce.start(
          const Duration(seconds: 1),
          () => {
                _groupRepository
                    .getGroupsByPathOfName(_fieldValue)
                    .then((groups) {
                  if (_fieldValue.isEmpty) {
                    _loading = false;

                    _loadingCompleted = false;

                    _searchResult.clear();

                    notifyListeners();

                    return;
                  }

                  for (var group in groups) {
                    if (group.numberOfSubgroups > 0) {
                      for (int i = 0; i < group.numberOfSubgroups; i++) {
                        var groupWrapper =
                            GroupWrapper(group: group, subgroupNumber: i + 1);
                        _searchResult.add(groupWrapper);
                      }
                    } else {
                      var groupWrapper = GroupWrapper(group: group);
                      _searchResult.add(groupWrapper);
                    }
                  }

                  _loading = false;

                  _loadingCompleted = true;

                  notifyListeners();
                }).catchError((error) {
                  Fluttertoast.showToast(
                      msg: "Возникла ошибка, проверте соединение с интернетом",
                      fontSize: 14,
                      gravity: ToastGravity.BOTTOM);
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

  void onGroupWrapperClick(GroupWrapper wrapper) {
    _userManager.switchToStudent(
        Student(
            group: wrapper.group, subgroupNumber: wrapper.subgroupNumber));

    context.router.replaceAll([const HomeRoute()]);
  }
}
