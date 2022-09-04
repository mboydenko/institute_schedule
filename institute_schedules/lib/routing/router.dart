import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/presentation/pages/coursework_schedule/coursework_schedule_page.dart';
import 'package:institute_schedules/presentation/pages/credit_schedule/credit_schedule_page.dart';
import 'package:institute_schedules/presentation/pages/exam_schedule/exam_schedule_page.dart';
import 'package:institute_schedules/presentation/pages/lesson_details/lesson_details_page.dart';
import 'package:institute_schedules/presentation/pages/lessons_schedule/lesson_schedule_page.dart';
import 'package:institute_schedules/presentation/pages/schedules/schedules_page.dart';
import 'package:institute_schedules/presentation/pages/teacher_information/teacher_information_page.dart';
import 'package:institute_schedules/presentation/pages/teacher_selection/teacher_selection_page.dart';
import 'package:institute_schedules/presentation/pages/user_student_profile_selection/user_student_profile_selection_page.dart';
import 'package:institute_schedules/presentation/pages/user_teacher_profile_selection/user_teacher_profile_selection_page.dart';
import 'package:institute_schedules/presentation/pages/user_type_selection/user_type_selection_page.dart';
import 'package:institute_schedules/routing/guards/user_initialized_guard.dart';

@AdaptiveAutoRouter(
    replaceInRouteName: 'View,Route',
    routes: <AutoRoute>[
  AutoRoute(
    initial: true,
    path: '/',
    name: "HomeRoute",
    page: EmptyRouterPage,
    guards: [UserInitializedGuard],
    children: [
      AutoRoute(
          path: '',
          name: 'SchedulesRoute',
          page: SchedulesPage
      ),
      AutoRoute(
          path: 'lessons',
          name: 'LessonScheduleRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: LessonSchedulePage
            ),
            RedirectRoute(path: '*', redirectTo: '')
          ]
      ),
      AutoRoute(
          path: 'exams',
          name: 'ExamScheduleRoute',
          page:  ExamSchedulePage
      ),
      AutoRoute(
          path: 'credits',
          name: 'CreditScheduleRoute',
          page: CreditSchedulePage
      ),
      AutoRoute(
          path: 'coursework',
          name: 'CourseworkScheduleRoute',
          page: CourseworkSchedulePage
      ),
      AutoRoute(
          name: 'TeacherConsultationsRoute',
          path: 'teachers',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: TeacherSelectionPage,
            ),
            AutoRoute(
                name: 'TeacherInformationRoute',
                page: TeacherInformationPage
            ),
            RedirectRoute(path: '*', redirectTo: '')
          ]
      ),
      AutoRoute(
          path:'details',
          name: 'LessonDetailsRoute',
          page: LessonDetailsPage
      ),
      RedirectRoute(path: "*", redirectTo: '')
    ]
  ),
  AutoRoute(
    name: 'AuthRoute',
    path: '/auth',
    page: EmptyRouterPage,
    children: [
      AutoRoute(
        path: '',
        page: UserTypeSelectionPage
      ),
      AutoRoute(
        path: 'student',
        name: 'StudentProfileSelectionRoute',
        page: UserStudentProfileSelectionPage
      ),
      AutoRoute(
        path: 'teacher',
        name: 'TeacherProfileSelectionRoute',
        page: UserTeacherProfileSelectionPage
      ),
      RedirectRoute(
        path: '*',
        redirectTo: ''
      )
    ]
  )
])
class $ApplicationRouter {}