

import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/chair.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/discipline.dart';
import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';

final groups = <Group>[
  Group(name: "38-1", id: 1, numberOfSubgroups: 2),
  Group(name: "38-2", id: 2, numberOfSubgroups: 2),
  Group(name: "39-2", id: 3, numberOfSubgroups: 0)
];

final teachers = <Teacher>[
  Teacher(
      id: 1,
      firstName: "Artem",
      lastName: "Golubnichy",
      middleName: "Alexandovich"),
  Teacher(
      id: 2,
      firstName: "Sergey",
      lastName: "Romanyuk",
      middleName: "Victorovich"),
  Teacher(
      id: 3,
      firstName: "Serger",
      lastName: "Baydeshev",
      middleName: "Victorivich"),
  Teacher(
      id: 4,
      firstName: "Vladimir",
      lastName: "Kotlov",
      middleName: "Nickolaevich"),
  Teacher(
      id: 5,
      firstName: "Sergey",
      lastName: "Romonyuk",
      middleName: "Victorovich"),
];

final chairs = <Chair>[
  Chair(
      name: "ПОВТиАС",
      abbreviation: "ПОВТиАС",
      teachers: [teachers[0], teachers[3]],
      id: 1),
  Chair(
      name: "ИТИС",
      abbreviation: "ИТИС",
      teachers: [teachers[1], teachers[2]],
      id: 2),
  Chair(
      name: "АТАС",
      abbreviation: "АТАС",
      teachers: [
        teachers[4],
      ],
      id: 3)
];


final buildings = <Building>[
  Building(id: 1, name: "Главный корпус", shortName: "Гл.корп"),
  Building(id: 2, name: "Корпус Б", shortName: "Б"),
  Building(id: 3, name: "Корпус С", shortName: "C"),
  Building(id: 3, name: "Музыкальный коледж", shortName: "Муз.коледж")
];

final disciplines = <Discipline>[
  Discipline(name: "Математика", id: 1),
  Discipline(name: "История", id: 2),
  Discipline(name: "Основы программирования", id: 3),
  Discipline(name: "Программирование микроконтроллеров", id: 4),
  Discipline(name: "Администрирование операционных систем", id: 5)
];

