import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';

import '../../interfaces/credit_repository.dart';
import '../../entities/credit.dart';

abstract class CreditSchedule extends ChangeNotifier {
  @protected
  CreditRepository creditRepository = GetIt.instance.get<CreditRepository>();

  List<Credit> _credits = [];

  bool _loading = false;

  bool _loadingCompleted = false;

  bool get isLoading => _loading;

  bool get isLoadingCompleted => _loadingCompleted;

  List<Credit> get credits => [..._credits];

  List<Credit> getCreditsByDate(Date date) {
    List<Credit> credits = [];

    for (var credit in _credits) {
      Date creditDate = credit.date;

      if (date.day == creditDate.day &&
          date.month == creditDate.month &&
          date.year == creditDate.year) {
        credits.add(credit);
      }
    }
    return credits;
  }

  void update() {
    _loading = true;

    _loadingCompleted = false;


    notifyListeners();

    load().then((credits) {
      _credits = [...credits];

      _loading = false;

      _loadingCompleted = true;

      notifyListeners();
    }).catchError((error){
      Fluttertoast.showToast(
          msg: "Возникла ошибка, проверте соединение с интернетом",
          fontSize: 14,
          gravity: ToastGravity.BOTTOM
      );
      _credits.clear();
      _loading = false;
      _loadingCompleted =true;
      notifyListeners();
    });
  }

  @protected
  Future<List<Credit>> load();
}
