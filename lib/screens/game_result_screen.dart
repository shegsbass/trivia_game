import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trivia_game/components/text_size_14.dart';
import 'package:trivia_game/screens/get_started_screen.dart';

import '../components/primary_button.dart';
import '../utils/app_colors.dart';

class GameResult extends StatefulWidget {
  GameResult({super.key, required this.correctCount, required this.wrongCount, required this.elapsedSeconds,});

  final int correctCount;
  final int wrongCount;
  final int elapsedSeconds;

  @override
  State<GameResult> createState() => _GameResultState();
}

class _GameResultState extends State<GameResult> {

  AudioPlayer audioPlayer = AudioPlayer();

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String formattedTime =
        '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
        '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return formattedTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  void playSong() async {
    audioPlayer.play(AssetSource('finished_trumpet.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    bool won = widget.correctCount > widget.wrongCount;

    return Scaffold(
    backgroundColor: AppColors.bg_color,
    body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_design.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Results',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF9F9F9),
                fontSize: 24,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 11),
            Container(
              width: 380,
              height: 76,
              decoration: ShapeDecoration(
                color: Color(0xFFDFF9FF),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF00CBF7),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Time Used: ${formatTime(widget.elapsedSeconds)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.correctCount} Correct',
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 9),
                      SvgPicture.asset('assets/correct.svg'),
                      SizedBox(width: 24),
                      Container(
                        width: 2,
                        height: 30,
                        color: Color(0xFF5A5A5A),
                      ),
                      SizedBox(width: 24),
                      Text(
                        '${widget.wrongCount} Incorrect',
                        style: TextStyle(
                          color: Color(0xFF1B1B1B),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 9),
                      SvgPicture.asset('assets/cancel.svg'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 28),
            SizedBox(
              height: 256,
              child: Container(
                width: 381,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFDFF9FF),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF00CBF7),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 40,
                      offset: Offset(4, 16),
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        won ? '😃' : '😢',
                        style: TextStyle(
                          fontSize: 60,
                        ),
                      ),
                      TextSize14(
                        text: won ? 'You did great!' : 'Better luck next time',
                        color: Colors.black,
                      ),
                      SizedBox(height: 17),
                      TextSize14(
                        text: won ? 'Congratulations You Won 🎉' : 'Sorry, you didn\'t win',
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Spacer(),

            PrimaryButton(
              text: 'Go Home',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetStartedScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
