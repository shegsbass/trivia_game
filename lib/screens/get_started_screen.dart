import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:trivia_game/components/primary_button.dart';
import 'package:trivia_game/screens/game_result_screen.dart';
import 'package:trivia_game/screens/game_screen.dart';
import 'package:trivia_game/utils/app_colors.dart';

class GetStartedScreen extends StatefulWidget {
  GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  void playSong() async {
    audioPlayer.play(AssetSource('intro.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
                fit: BoxFit.cover
              )
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 372,
                      child: Text(
                        'Play Trivia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0FDCFE),
                          fontSize: 36,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  text: 'Start Now',
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                        builder: (context) => GameScreen()
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