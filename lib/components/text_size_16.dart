import 'package:flutter/material.dart';

class TextSize16 extends StatelessWidget {
  final String text;
  final Color color;

  TextSize16({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}