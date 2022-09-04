import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitRing(color: Color.fromRGBO(59, 123, 182, 1), lineWidth: 3 );
  }
}