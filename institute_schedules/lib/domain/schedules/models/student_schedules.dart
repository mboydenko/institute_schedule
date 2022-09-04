
import '../entities/student.dart';

import 'schedules.dart';
import 'exams/student_exam_schedule.dart';
import 'lessons/student_lesson_schedule.dart';
import 'credits/student_credit_schedule.dart';
import 'courseworks/student_coursework_schedule.dart';

class StudentSchedules extends Schedules {
  final Student student;

  StudentSchedules(this.student) : super(
    lessons: StudentLessonSchedule(student),
    courseworks: StudentCourseworkSchedule(student: student),
    credits: StudentCreditSchedule(student: student),
    exams: StudentExamSchedule(student: student)
  );
}