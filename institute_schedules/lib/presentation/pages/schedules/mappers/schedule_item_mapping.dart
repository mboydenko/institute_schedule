import 'package:institute_schedules/domain/schedules/entities/coursework.dart';
import 'package:institute_schedules/domain/schedules/entities/credit.dart';
import 'package:institute_schedules/domain/schedules/entities/exam.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/pre_exam_consultation.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';

import '../entities/schedule_item.dart';

class ScheduleItemMapping {
  static ScheduleItem fromExam(Exam exam) {
    return ScheduleItem(
        type: exam.type == ExamType.consultation
            ? ScheduleItemType.consultation
            : ScheduleItemType.exam,
        startTime: exam.time,
        discipline: exam.discipline,
        groups: exam.groups
            .map((e) => ScheduleItemGroup(group: e, subgroupNumber: 0))
            .toList(),
        teachers: [exam.teacher],
        building: exam.building,
        classRoom: exam.classRoom);
  }

  static ScheduleItem fromPreExamConsultation(
      PreExamConsultation consultation) {
    return ScheduleItem(
        type: ScheduleItemType.consultation,
        startTime: consultation.time,
        discipline: consultation.discipline,
        groups: consultation.groups
            .map((e) => ScheduleItemGroup(group: e, subgroupNumber: 0))
            .toList(),
        teachers: [consultation.teacher],
        building: consultation.building,
        classRoom: consultation.classRoom);
  }

  static ScheduleItem fromLesson(Lesson lesson, Time startTime, Time endTime) {
    return ScheduleItem(
        type: lesson.lessonType == LessonType.lecture
            ? ScheduleItemType.lecture
            : lesson.lessonType == LessonType.laboratoryWork
                ? ScheduleItemType.laboratoryWork
                : lesson.lessonType == LessonType.practice
                    ? ScheduleItemType.practice
                    : throw Exception("Invalid type"),
        startTime: startTime,
        endTime: endTime,
        discipline: lesson.discipline,
        groups: lesson.groups
            .map((e) => ScheduleItemGroup(
                group: e.group, subgroupNumber: e.subgroupNumber))
            .toList(),
        teachers: [lesson.teacher],
        building: lesson.building,
        classRoom: lesson.classRoom);
  }

  static ScheduleItem fromCredit(Credit credit) {
    return ScheduleItem(
        type: ScheduleItemType.credit,
        startTime: credit.time,
        discipline: credit.discipline,
        groups: [
          ScheduleItemGroup(
              group: credit.group,
              subgroupNumber: credit.subgroupNumber
          )
        ],
        teachers: [credit.teacher],
        building: credit.building,
        classRoom: credit.classRoom);
  }

  static ScheduleItem fromCoursework(Coursework coursework) {
    return ScheduleItem(
        type: ScheduleItemType.coursework,
        startTime: coursework.time,
        discipline: coursework.discipline,
        groups: [coursework.group]
            .map((e) => ScheduleItemGroup(group: e, subgroupNumber: 0))
            .toList(),
        teachers: coursework.commissionComposition,
        building: coursework.building,
        classRoom: coursework.classRoom);
  }
}
