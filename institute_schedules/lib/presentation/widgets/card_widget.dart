import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String? title;

  final Widget body;

  const CardWidget({Key? key, required this.body, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 4, offset: Offset.zero, blurStyle: BlurStyle.solid)
        ],
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        children: [
          Visibility(
              visible: title != null,
              child: _Title(title: title ?? "")
          ),
          body
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text(title, style: const TextStyle(
            color: Colors.white, fontFamily: 'Roboto', fontSize: 16))
      ),
    );
  }
}