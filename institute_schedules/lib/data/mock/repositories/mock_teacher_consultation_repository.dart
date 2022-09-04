
import 'dart:async';

import 'package:institute_schedules/data/mock/mock_data.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher_consultation.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_consultation_repository.dart';

class MockTeacherConsultationRepository extends TeacherConsultationRepository {
  @override
  Future<List<TeacherConsultation>> getTeacherConsultationsById(
      int teacherId) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      // TeacherConsultation(
      //     id: 1,
      //     name: "Консультация по дипломной работе",
      //     day: DayType.friday,
      //     time: Time(hours: 10, minutes: 30),
      //     teacher: teachers[1],
      //     weekType: WeekType.even,
      //     weekDay: DayType.friday
      // ),
      // TeacherConsultation(
      //     id: 1,
      //     name: "Консультация по дипломной работе",
      //     day: DayType.monday,
      //     time: Time(hours: 10, minutes: 30),
      //     teacher: teachers[1],
      //     weekType: WeekType.even,
      //     weekDay: DayType.monday
      // )
    ];
  }
}
