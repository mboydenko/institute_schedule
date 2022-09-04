import '../../entities/lesson.dart';
import '../../entities/student.dart';

import 'lesson_schedule.dart';

class StudentLessonSchedule extends LessonSchedule {
  final Student student;

  StudentLessonSchedule(
    this.student
  ) : super();

  @override
  Future<List<Lesson>> load() async {

    var lessons = await lessonRepository.getLessonsByGroupId(student.group.id);

    var subgroupLessons = <Lesson>[];

    for (var lesson in lessons) {
      if(lesson.subgroupNumber == student.subgroupNumber || lesson.subgroupNumber == 0) {
        subgroupLessons.add(lesson);
      }
    }

    return subgroupLessons;
  }
}