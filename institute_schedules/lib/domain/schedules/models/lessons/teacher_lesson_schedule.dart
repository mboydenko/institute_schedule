import '../../entities/lesson.dart';
import '../../entities/teacher.dart';

import 'lesson_schedule.dart';

class TeacherLessonSchedule extends LessonSchedule {
  final Teacher teacher;

  TeacherLessonSchedule({required this.teacher}) : super();

  @override
  Future<List<Lesson>> load() async {
    var allLessons = await lessonRepository.getLessonsByTeacherId(teacher.id);

    var result = <Lesson>[];

    for (var lesson in allLessons) {
      if(_doesLessonExist(lesson, result)) {
        continue;
      }else {
        result.add(lesson);
      }
    }
    return result;
  }

  bool _doesLessonExist(Lesson lesson, List<Lesson> lessons) {
    for(var element in lessons) {
      if(
      lesson.discipline.id == element.discipline.id &&
          lesson.building.id == element.building.id &&
          lesson.classRoom.id == element.classRoom.id &&
          lesson.number == element.number &&
          lesson.weekType == element.weekType &&
          lesson.dayType == element.dayType &&
          lesson.lessonType == element.lessonType
      ) {
        return true;
      }
    }
    return false;
  }
}
