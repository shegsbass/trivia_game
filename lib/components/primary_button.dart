import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_game/utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, required this.onTap});

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        child: Stack(
          children: [
            Positioned(
              left: (335 - 320) / 2,
              top: 26,
              child: Container(
                width: 320,
                height: 44,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1, -0.86),
                    end: Alignment(1, 0.86),
                    colors: [Color(0xFFED7B2B), Color(0xFFFEE65E)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 335,
                height: 63,
                decoration: ShapeDecoration(
                  color: AppColors.btn_primary_color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: Color(0xFF3B3B3B),
                        fontSize: 18,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
