import 'package:flutter/material.dart';
import 'card_widget.dart';

class SearchTextFieldWidget extends StatelessWidget {

  final Function(String)? onChanged;

  final TextEditingController? controller;

  Color? backgroundColor;

  final String? placeholder;

  SearchTextFieldWidget({
    Key? key,
    Color? backgroundColor,
    this.placeholder,
    this.onChanged,
    this.controller,
  }) : super(key: key) {
    this.backgroundColor = backgroundColor ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: backgroundColor,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.search, color: Color.fromRGBO(100, 100, 100, 1)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(146, 146, 146, 1)),
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: placeholder,
                    hintStyle: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromRGBO(146, 146, 146, 0.5)),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

