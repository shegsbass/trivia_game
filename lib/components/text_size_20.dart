import 'package:flutter/material.dart';

class TextSize20 extends StatelessWidget {
  final String text;
  final Color color;

  TextSize20({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}