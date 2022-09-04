import 'package:flutter/material.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  int _index = 0;

  final List<Color> colors = [
    const Color.fromRGBO(59, 123, 182, 1),
    const Color.fromRGBO(7, 147, 64, 1)
  ];

  final List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  Color color1 = Color.fromRGBO(59, 123, 182, 1);
  Color color2 = Color.fromRGBO(7, 147, 64, 1);

  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      tick();
    }));
  }

  void tick() {
    _index = _index + 1;
    // animate the color
    color1 = colors[_index % colors.length];
    color2 = colors[(_index + 1) % colors.length];
    begin = alignmentList[_index % alignmentList.length];
    end = alignmentList[(_index + 2) % alignmentList.length];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      onEnd: () {
        setState(() {
          tick();
        });
      },
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
    );
  }
}
