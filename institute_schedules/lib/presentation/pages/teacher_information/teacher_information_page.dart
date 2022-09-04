import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/domain/schedules/constants/weeks.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';

import 'widgets/consultation_list_widget.dart';
import 'teacher_information_vm.dart';

class TeacherInformationPage extends StatelessWidget {
  final Teacher teacher;

  const TeacherInformationPage({Key? key, required this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TeacherInformationVM(teacher: teacher),
        child: _TeacherInformationView());
  }
}

class _TeacherInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TeacherInformationVM>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          context.router.pop();
        }),
        actions: [
          IconButton(onPressed: (){
            model.onUpdateButtonClicked();
          }, icon: const Icon(Icons.update_rounded))
        ],
        title: Text(model.teacher.lastNameWithInitials),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TeacherInformationVM>(context, listen: false);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 15, top: 16, right: 15, bottom: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _TeacherWidget(
                    name:
                        "${model.teacher.lastName} ${model.teacher.firstName} ${model.teacher.middleName}"),
                const SizedBox(
                  height: 16,
                ),
                _InformationWidget(
                    topLabel: "Электронная почта:",
                    bottomLabel: model.teacher.email ?? ""),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                _InformationWidget(
                    topLabel: "Кафедра:",
                    bottomLabel: model.teacher.chair != null
                        ? model.teacher.chair!.abbreviation
                        : "")
              ]),
          ),
          Container(
            height: 6,
            color: const Color.fromRGBO(0, 0, 0, 0.17),
          ),
          Expanded(
              child: _TablesWidget()
          )
        ]);
  }
}

class _TeacherWidget extends StatelessWidget {
  final String name;

  const _TeacherWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  final String topLabel;

  final String bottomLabel;

  const _InformationWidget({required this.topLabel, required this.bottomLabel});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        topLabel,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Text(bottomLabel,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w300))
    ]);
  }
}

class _TablesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<_TablesWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      TabBar(controller: _tabController, tabs: const [
        Tab(
            icon: Text(
          ODD_WEEK_NAME,
        )),
        Tab(
            icon: Text(
          EVEN_WEEK_NAME,
        ))
      ]),
      Expanded(child: TabBarView(
          controller: _tabController,
          children: [
            _OddWeekConsultations(),
            _EvenWeekConsultations(),
          ]
      ))
    ]);
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CardWidget(
        body: SizedBox(
      height: 150,
      child: Center(
        child: SpinnerWithLabelWidget(
          layout: SpinnerWithLabelWidgetLayout.spinnerTop,
          text: "Загрузка расписания",
          textStyle: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    ));
  }
}

class _NoConsultations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CardWidget(
        body: SizedBox(
      height: 150,
      child: Center(
        child: Text(
          "Информация отсутсвует",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ));
  }
}

class _OddWeekConsultations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TeacherInformationVM>(context);

    Widget widget;

    if(kDebugMode) {
      print("Build OddWeekConsultations widget");
    }

    if (model.isConsultationLoadingCompleted) {
      if (model.oddWeekConsultations.isEmpty) {
        widget = _NoConsultations();
      } else {
        widget =
            ConsultationListWidget(consultations: model.oddWeekConsultations);
      }
    } else {
      widget = _Loading();
    }

    return SingleChildScrollView(
        child: Container(margin: const EdgeInsets.all(15), child: widget));
  }
}

class _EvenWeekConsultations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TeacherInformationVM>(context);

    Widget widget;

    if (model.isConsultationLoadingCompleted) {
      if (model.evenWeekConsultations.isEmpty) {
        widget = _NoConsultations();
      } else {
        widget =
            ConsultationListWidget(consultations: model.evenWeekConsultations);
      }
    } else {
      widget = _Loading();
    }

    return SingleChildScrollView(
        child: Container(margin: const EdgeInsets.all(15), child: widget));
  }
}
