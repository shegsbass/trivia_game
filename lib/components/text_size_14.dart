import 'package:flutter/material.dart';

class TextSize14 extends StatelessWidget {
  final String text;
  final Color color;

  TextSize14({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}