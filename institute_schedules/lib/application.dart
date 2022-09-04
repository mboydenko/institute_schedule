import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_schedules/data/services/courseworks/api_coursework_repository.dart';
import 'package:institute_schedules/data/services/credits/api_credit_repository.dart';
import 'package:institute_schedules/data/services/exams/api_exam_repository.dart';
import 'package:institute_schedules/data/services/groups/api_group_repository.dart';
import 'package:institute_schedules/data/services/lessons/api_lesson_repository.dart';
import 'package:institute_schedules/data/services/teachers/api_teacher_consultation_repository.dart';
import 'package:institute_schedules/data/services/teachers/api_teacher_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/coursework_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/credit_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/exam_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/group_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/lesson_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_consultation_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_repository.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import 'package:institute_schedules/presentation/widgets/background_widget.dart';
import 'package:institute_schedules/routing/guards/user_initialized_guard.dart';
import './routing/router.gr.dart';
import 'data/mock/repositories/mock_coursework_repository.dart';

class Application extends StatelessWidget {
  final GroupRepository groupRepository = ApiGroupRepository();

  final TeacherRepository teacherRepository = ApiTeacherRepository();

  final CourseworkRepository courseworkRepository = ApiCourseworkRepository();

  final CreditRepository creditRepository = ApiCreditRepository();

  final ExamRepository examRepository = ApiExamRepository();

  final TeacherConsultationRepository teacherConsultationRepository =
      ApiTeacherConsultationRepository();

  final LessonRepository lessonRepository =
      ApiLessonRepository();

  late UserManager userManager;

  late ApplicationRouter router;

  Application({Key? key, required this.userManager}) : super(key: key) {
    initGetIt();
    router = ApplicationRouter(
        userInitializedGuard: UserInitializedGuard(userManager));
  }

  void initGetIt() {
    // This is important.
    var instance = GetIt.instance;

    instance.allowReassignment = true;

    instance.registerSingleton<GroupRepository>(groupRepository);
    instance.registerSingleton<TeacherRepository>(teacherRepository);
    instance.registerSingleton<ExamRepository>(examRepository);
    instance.registerSingleton<CreditRepository>(creditRepository);
    instance.registerSingleton<CourseworkRepository>(courseworkRepository);
    instance.registerSingleton<TeacherConsultationRepository>(
        teacherConsultationRepository);
    instance
        .registerSingleton<LessonRepository>(lessonRepository);
    instance.registerSingleton<UserManager>(userManager);

    // if (Platform.isAndroid) {
    //   setupAndroidToolbarColor();
    // }
  }

  void setupAndroidToolbarColor() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      const BackgroundWidget(),
      MaterialApp.router(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        theme: theme,
        routeInformationParser: router.defaultRouteParser(),
        routerDelegate: router.delegate(),
      )
    ]);
  }

  ThemeData get theme {
    return ThemeData(
      indicatorColor: Colors.white,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          titleSpacing: 14,
          color: Color.fromRGBO(0, 0, 0, 0.32),
          toolbarHeight: 70,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.white,
        height: 60,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.32),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromRGBO(84, 255, 152, 1),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.32),
      ),
      buttonTheme: const ButtonThemeData(
          hoverColor: Colors.transparent, alignedDropdown: false),
      tabBarTheme: const TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          unselectedLabelStyle:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: const Color.fromRGBO(0, 0, 0, 1)),
    );
  }
}
