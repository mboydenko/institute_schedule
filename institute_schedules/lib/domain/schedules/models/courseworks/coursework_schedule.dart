import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import '../../entities/coursework.dart';
import '../../interfaces/coursework_repository.dart';

abstract class CourseworkSchedule extends ChangeNotifier {
  @protected
  CourseworkRepository courseworkRepository =
      GetIt.instance.get<CourseworkRepository>();

  List<Coursework> _courseworks = [];

  bool _loading = false;

  bool _loadingCompleted = false;

  bool get isLoading => _loading;

  bool get isLoadingCompleted => _loadingCompleted;

  List<Coursework> get courseworks => [..._courseworks];

  void update() {
    _loading = true;

    _loadingCompleted = false;

    notifyListeners();

    load().then((courseworks) {
      _courseworks = [...courseworks];

      _loadingCompleted = true;

      _loading = false;

      notifyListeners();
    }).catchError((error){
      Fluttertoast.showToast(
          msg: "Возникла ошибка, проверте соединение с интернетом",
          fontSize: 14,
          gravity: ToastGravity.BOTTOM
      );
      _courseworks.clear();
      _loading = false;
      _loadingCompleted =true;
      notifyListeners();
    });
  }

  List<Coursework> getCourseWorksByDate(Date date) {
    var courseWorks = <Coursework>[];

    for(var coursework in courseworks) {
      if(
      coursework.date.year == date.year &&
      coursework.date.month == date.month &&
      coursework.date.day == date.day
      ) {
        courseWorks.add(coursework);
      }
    }

    return courseWorks;
  }

  @protected
  Future<List<Coursework>> load();
}
