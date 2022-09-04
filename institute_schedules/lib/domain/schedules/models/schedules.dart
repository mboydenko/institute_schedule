import 'package:flutter/foundation.dart';

import 'lessons/lesson_schedule.dart';
import 'exams/exam_schedule.dart';
import 'credits/credit_schedule.dart';
import 'courseworks/coursework_schedule.dart';

abstract class Schedules extends ChangeNotifier {
  final LessonSchedule lessons;

  final ExamSchedule exams;

  final CreditSchedule credits;

  final CourseworkSchedule courseworks;

  Schedules(
      {required this.lessons,
        required this.exams,
        required this.credits,
        required this.courseworks})
      : super() {
    lessons.addListener(_onChanged);

    exams.addListener(_onChanged);

    credits.addListener(_onChanged);

    courseworks.addListener(_onChanged);

    update();
  }

  void update() {
    lessons.update();

    exams.update();

    credits.update();

    courseworks.update();
  }

  bool get isLoading =>
      lessons.isLoading ||
          exams.loading ||
          credits.isLoading ||
          courseworks.isLoading;

  bool get isLoadingCompleted => lessons.isLoadingCompleted &&
      exams.loadingCompleted &&
      credits.isLoadingCompleted &&
      courseworks.isLoadingCompleted;


  void _onChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    lessons.removeListener(_onChanged);

    exams.removeListener(_onChanged);

    credits.removeListener(_onChanged);

    courseworks.removeListener(_onChanged);

    super.dispose();
  }
}
