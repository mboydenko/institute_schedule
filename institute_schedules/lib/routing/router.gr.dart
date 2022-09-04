// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i15;
import 'package:flutter/material.dart' as _i13;
import 'package:institute_schedules/domain/schedules/entities/lesson.dart'
    as _i16;
import 'package:institute_schedules/domain/schedules/entities/teacher.dart'
    as _i17;
import 'package:institute_schedules/presentation/pages/coursework_schedule/coursework_schedule_page.dart'
    as _i5;
import 'package:institute_schedules/presentation/pages/credit_schedule/credit_schedule_page.dart'
    as _i4;
import 'package:institute_schedules/presentation/pages/exam_schedule/exam_schedule_page.dart'
    as _i3;
import 'package:institute_schedules/presentation/pages/lesson_details/lesson_details_page.dart'
    as _i6;
import 'package:institute_schedules/presentation/pages/lessons_schedule/lesson_schedule_page.dart'
    as _i7;
import 'package:institute_schedules/presentation/pages/schedules/schedules_page.dart'
    as _i2;
import 'package:institute_schedules/presentation/pages/teacher_information/teacher_information_page.dart'
    as _i9;
import 'package:institute_schedules/presentation/pages/teacher_selection/teacher_selection_page.dart'
    as _i8;
import 'package:institute_schedules/presentation/pages/user_student_profile_selection/user_student_profile_selection_page.dart'
    as _i11;
import 'package:institute_schedules/presentation/pages/user_teacher_profile_selection/user_teacher_profile_selection_page.dart'
    as _i12;
import 'package:institute_schedules/presentation/pages/user_type_selection/user_type_selection_page.dart'
    as _i10;
import 'package:institute_schedules/routing/guards/user_initialized_guard.dart'
    as _i14;

class ApplicationRouter extends _i1.RootStackRouter {
  ApplicationRouter(
      {_i13.GlobalKey<_i13.NavigatorState>? navigatorKey,
      required this.userInitializedGuard})
      : super(navigatorKey);

  final _i14.UserInitializedGuard userInitializedGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    AuthRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    SchedulesRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.SchedulesPage());
    },
    LessonScheduleRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    ExamScheduleRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.ExamSchedulePage());
    },
    CreditScheduleRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.CreditSchedulePage());
    },
    CourseworkScheduleRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.CourseworkSchedulePage());
    },
    TeacherConsultationsRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    LessonDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<LessonDetailsRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.LessonDetailsPage(key: args.key, lesson: args.lesson));
    },
    LessonSchedulePage.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.LessonSchedulePage());
    },
    TeacherSelectionPage.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i8.TeacherSelectionPage());
    },
    TeacherInformationRoute.name: (routeData) {
      final args = routeData.argsAs<TeacherInformationRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child:
              _i9.TeacherInformationPage(key: args.key, teacher: args.teacher));
    },
    UserTypeSelectionPage.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.UserTypeSelectionPage());
    },
    StudentProfileSelectionRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i11.UserStudentProfileSelectionPage());
    },
    TeacherProfileSelectionRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i12.UserTeacherProfileSelectionPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/', guards: [
          userInitializedGuard
        ], children: [
          _i1.RouteConfig(SchedulesRoute.name,
              path: '', parent: HomeRoute.name),
          _i1.RouteConfig(LessonScheduleRoute.name,
              path: 'lessons',
              parent: HomeRoute.name,
              children: [
                _i1.RouteConfig(LessonSchedulePage.name,
                    path: '', parent: LessonScheduleRoute.name),
                _i1.RouteConfig('*#redirect',
                    path: '*',
                    parent: LessonScheduleRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i1.RouteConfig(ExamScheduleRoute.name,
              path: 'exams', parent: HomeRoute.name),
          _i1.RouteConfig(CreditScheduleRoute.name,
              path: 'credits', parent: HomeRoute.name),
          _i1.RouteConfig(CourseworkScheduleRoute.name,
              path: 'coursework', parent: HomeRoute.name),
          _i1.RouteConfig(TeacherConsultationsRoute.name,
              path: 'teachers',
              parent: HomeRoute.name,
              children: [
                _i1.RouteConfig(TeacherSelectionPage.name,
                    path: '', parent: TeacherConsultationsRoute.name),
                _i1.RouteConfig(TeacherInformationRoute.name,
                    path: 'teacher-information-page',
                    parent: TeacherConsultationsRoute.name),
                _i1.RouteConfig('*#redirect',
                    path: '*',
                    parent: TeacherConsultationsRoute.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i1.RouteConfig(LessonDetailsRoute.name,
              path: 'details', parent: HomeRoute.name),
          _i1.RouteConfig('*#redirect',
              path: '*',
              parent: HomeRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i1.RouteConfig(AuthRoute.name, path: '/auth', children: [
          _i1.RouteConfig(UserTypeSelectionPage.name,
              path: '', parent: AuthRoute.name),
          _i1.RouteConfig(StudentProfileSelectionRoute.name,
              path: 'student', parent: AuthRoute.name),
          _i1.RouteConfig(TeacherProfileSelectionRoute.name,
              path: 'teacher', parent: AuthRoute.name),
          _i1.RouteConfig('*#redirect',
              path: '*',
              parent: AuthRoute.name,
              redirectTo: '',
              fullMatch: true)
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute({List<_i1.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class AuthRoute extends _i1.PageRouteInfo<void> {
  const AuthRoute({List<_i1.PageRouteInfo>? children})
      : super(AuthRoute.name, path: '/auth', initialChildren: children);

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i2.SchedulesPage]
class SchedulesRoute extends _i1.PageRouteInfo<void> {
  const SchedulesRoute() : super(SchedulesRoute.name, path: '');

  static const String name = 'SchedulesRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class LessonScheduleRoute extends _i1.PageRouteInfo<void> {
  const LessonScheduleRoute({List<_i1.PageRouteInfo>? children})
      : super(LessonScheduleRoute.name,
            path: 'lessons', initialChildren: children);

  static const String name = 'LessonScheduleRoute';
}

/// generated route for
/// [_i3.ExamSchedulePage]
class ExamScheduleRoute extends _i1.PageRouteInfo<void> {
  const ExamScheduleRoute() : super(ExamScheduleRoute.name, path: 'exams');

  static const String name = 'ExamScheduleRoute';
}

/// generated route for
/// [_i4.CreditSchedulePage]
class CreditScheduleRoute extends _i1.PageRouteInfo<void> {
  const CreditScheduleRoute()
      : super(CreditScheduleRoute.name, path: 'credits');

  static const String name = 'CreditScheduleRoute';
}

/// generated route for
/// [_i5.CourseworkSchedulePage]
class CourseworkScheduleRoute extends _i1.PageRouteInfo<void> {
  const CourseworkScheduleRoute()
      : super(CourseworkScheduleRoute.name, path: 'coursework');

  static const String name = 'CourseworkScheduleRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class TeacherConsultationsRoute extends _i1.PageRouteInfo<void> {
  const TeacherConsultationsRoute({List<_i1.PageRouteInfo>? children})
      : super(TeacherConsultationsRoute.name,
            path: 'teachers', initialChildren: children);

  static const String name = 'TeacherConsultationsRoute';
}

/// generated route for
/// [_i6.LessonDetailsPage]
class LessonDetailsRoute extends _i1.PageRouteInfo<LessonDetailsRouteArgs> {
  LessonDetailsRoute({_i15.Key? key, required _i16.Lesson lesson})
      : super(LessonDetailsRoute.name,
            path: 'details',
            args: LessonDetailsRouteArgs(key: key, lesson: lesson));

  static const String name = 'LessonDetailsRoute';
}

class LessonDetailsRouteArgs {
  const LessonDetailsRouteArgs({this.key, required this.lesson});

  final _i15.Key? key;

  final _i16.Lesson lesson;

  @override
  String toString() {
    return 'LessonDetailsRouteArgs{key: $key, lesson: $lesson}';
  }
}

/// generated route for
/// [_i7.LessonSchedulePage]
class LessonSchedulePage extends _i1.PageRouteInfo<void> {
  const LessonSchedulePage() : super(LessonSchedulePage.name, path: '');

  static const String name = 'LessonSchedulePage';
}

/// generated route for
/// [_i8.TeacherSelectionPage]
class TeacherSelectionPage extends _i1.PageRouteInfo<void> {
  const TeacherSelectionPage() : super(TeacherSelectionPage.name, path: '');

  static const String name = 'TeacherSelectionPage';
}

/// generated route for
/// [_i9.TeacherInformationPage]
class TeacherInformationRoute
    extends _i1.PageRouteInfo<TeacherInformationRouteArgs> {
  TeacherInformationRoute({_i15.Key? key, required _i17.Teacher teacher})
      : super(TeacherInformationRoute.name,
            path: 'teacher-information-page',
            args: TeacherInformationRouteArgs(key: key, teacher: teacher));

  static const String name = 'TeacherInformationRoute';
}

class TeacherInformationRouteArgs {
  const TeacherInformationRouteArgs({this.key, required this.teacher});

  final _i15.Key? key;

  final _i17.Teacher teacher;

  @override
  String toString() {
    return 'TeacherInformationRouteArgs{key: $key, teacher: $teacher}';
  }
}

/// generated route for
/// [_i10.UserTypeSelectionPage]
class UserTypeSelectionPage extends _i1.PageRouteInfo<void> {
  const UserTypeSelectionPage() : super(UserTypeSelectionPage.name, path: '');

  static const String name = 'UserTypeSelectionPage';
}

/// generated route for
/// [_i11.UserStudentProfileSelectionPage]
class StudentProfileSelectionRoute extends _i1.PageRouteInfo<void> {
  const StudentProfileSelectionRoute()
      : super(StudentProfileSelectionRoute.name, path: 'student');

  static const String name = 'StudentProfileSelectionRoute';
}

/// generated route for
/// [_i12.UserTeacherProfileSelectionPage]
class TeacherProfileSelectionRoute extends _i1.PageRouteInfo<void> {
  const TeacherProfileSelectionRoute()
      : super(TeacherProfileSelectionRoute.name, path: 'teacher');

  static const String name = 'TeacherProfileSelectionRoute';
}
