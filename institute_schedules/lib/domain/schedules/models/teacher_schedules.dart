import '../entities/teacher.dart';

import 'schedules.dart';
import 'exams/teacher_exam_schedule.dart';
import 'credits/teacher_credit_schedule.dart';
import 'courseworks/teacher_coursework_schedule.dart';
import 'lessons/teacher_lesson_schedule.dart';

class TeacherSchedules extends Schedules {
  final Teacher teacher;

  TeacherSchedules(this.teacher) : super(
    exams: TeacherExamSchedule(teacher: teacher),
    credits: TeacherCreditSchedule(teacher: teacher),
    courseworks: TeacherCourseworkSchedule(teacher: teacher),
    lessons: TeacherLessonSchedule(teacher: teacher)
  );
}