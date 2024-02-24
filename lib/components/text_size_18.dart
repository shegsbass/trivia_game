import 'package:flutter/material.dart';

class TextSize18 extends StatelessWidget {
  final String text;

  TextSize18({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}