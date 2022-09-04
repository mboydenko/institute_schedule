import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:institute_schedules/routing/router.gr.dart';


import 'user_type_selection_vm.dart';

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserTypeSelectionVM(context),
      child: _UserTypeSelectionVM()
    );
  }
}

class _UserTypeSelectionVM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var model = context.read<UserTypeSelectionVM>();

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Logo(),
            const SizedBox(height: 23),
            const _Title("Расписание занятий"),
            const SizedBox(height: 13),
            const Center(
              child: _Description(
                  'Лучший помощник для студентов и преподавателей'),
            ),
            const SizedBox(height: 27),
            _Button(text: "Я СТУДЕНТ", onClick: () {
              model.onStudentButtonClick();
            }),
            const SizedBox(height: 20),
            _Button(text: "Я ПРЕПОДАВАТЕЛЬ", onClick: () {
              model.onTeacherButtonClick();
            })
          ],
        ));
  }

}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SvgPicture.asset('assets/images/schedule_icon.svg', width: 400, color: Colors.white),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontFamily: 'Robot',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Colors.white),
    );
  }
}

class _Button extends StatelessWidget {
  final Function onClick;
  final String text;

  const _Button({Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side: const BorderSide(
                width: 2,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () => onClick(),
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  fontSize: 18))),
    );
  }
}

class _Description extends StatelessWidget {
  final String text;

  const _Description(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
