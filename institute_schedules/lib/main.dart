import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:institute_schedules/application.dart';
import 'package:institute_schedules/domain/users/models/user_manager.dart';
import 'package:institute_schedules/presentation/widgets/sidebar_widget.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initDotenv() async {
  if(kDebugMode) {
    await dotenv.load(fileName: '.env.dev');
  }else {
    await dotenv.load(fileName: '.env');
  }
}

Future<void> initHavi() async {
  await Hive.initFlutter();
}

void main() async {
  await initDotenv();

  await initHavi();

  var userManager = UserManager();

  await userManager.loadLastState();

  runApp(Application(userManager: userManager));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SidebarWidget(
          onAboutProgramButtonClick: (){},
          onChangeUserButtonClick: (){},
          onCourseworkScheduleButtonClick: (){},
          onCreditScheduleButtonClick: (){},
          onExamScheduleButtonClick: (){},
          onLessonScheduleButtonClick: (){},
          onTeacherConsultationsButtonClick: (){},
        )
      ),
    );
  }
}