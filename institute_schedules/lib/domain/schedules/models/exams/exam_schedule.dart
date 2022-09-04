import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import '../../interfaces/exam_repository.dart';
import '../../entities/exam.dart';
import '../../entities/date.dart';

abstract class ExamSchedule extends ChangeNotifier {
  @protected
  final ExamRepository examRepository = GetIt.instance.get<ExamRepository>();

  List<Exam> _exams = [];

  bool _loading = false;

  bool _loadingCompleted = false;

  bool get loading => _loading;

  bool get loadingCompleted => _loadingCompleted;

  List<Exam> getExamsByDate(Date date) {
    List<Exam> exams = [];

    for (var exam in _exams) {
      Date examDate = exam.date;

      if (date.day == examDate.day &&
          date.month == examDate.month &&
          date.year == examDate.year) {
        exams.add(exam);
      }
    }
    return exams;
  }

  List<Exam> get exams => [..._exams];

  void update() {
    _loading = true;

    _loadingCompleted = false;

    notifyListeners();

    load().then((exams) {
      _exams = [...exams];

      _loading = false;

      _loadingCompleted = true;

      notifyListeners();
    }).catchError((error){
      Fluttertoast.showToast(
          msg: "Возникла ошибка, проверте соединение с интернетом",
          fontSize: 14,
          gravity: ToastGravity.BOTTOM
      );
      _exams.clear();
      _loading = false;
      _loadingCompleted =true;
      notifyListeners();
    });
  }

  @protected
  Future<List<Exam>> load();
}
