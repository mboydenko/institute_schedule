import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';

import 'widgets/credit_widget.dart';

import 'credit_schedule_vm.dart';

class CreditSchedulePage extends StatelessWidget {
  const CreditSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreditScheduleVM(),
      child: const _CreditSchedulePage(),
    );
  }
}

class _CreditSchedulePage extends StatelessWidget {
  const _CreditSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CreditScheduleVM>(context, listen: false);
    return Scaffold(
      appBar: _appBar(model),
      body: _Body(),
    );
  }

  AppBar _appBar(CreditScheduleVM model) {
    return AppBar(
      title: const Text("Расписание зачетов"),
      actions: [
        IconButton(
            onPressed: () {
              model.onUpdateButtonClicked();
            },
            icon: const Icon(Icons.update_rounded))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CreditScheduleVM>(context);
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(15),
          child: model.isLoading
              ? _Loading()
              : model.credits.isNotEmpty
                  ? _CreditList()
                  : _NoCredits()),
    );
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
        text: "Загрузка расписания",
        layout: SpinnerWithLabelWidgetLayout.spinnerTop,
        textStyle: TextStyle(fontSize: 18, color: Colors.white),
      )),
    ));
  }
}

class _CreditList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CreditScheduleVM>(context, listen: false);

    final widgets = <Widget>[];

    for (var credit in model.credits) {
      widgets.add(CreditWidget(credit: credit));
      if (credit != model.credits.last) {
        widgets.add(const SizedBox(height: 20));
      }
    }

    return Column(
      children: widgets,
    );
  }
}

class _NoCredits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CardWidget(
        body: SizedBox(
      height: 150,
      child: Center(
        child: Text("Информация отсутсвуте",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    ));
  }
}
