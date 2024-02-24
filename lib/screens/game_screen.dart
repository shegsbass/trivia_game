import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game/components/circular_timer.dart';
import 'package:trivia_game/components/text_size_14.dart';
import 'package:trivia_game/components/text_size_16.dart';
import 'package:trivia_game/components/text_size_18.dart';
import 'package:trivia_game/components/text_size_20.dart';
import 'package:trivia_game/provider/questions_provider.dart';
import 'package:trivia_game/service/api_service.dart';

import '../network/QuestionsModel.dart';
import '../utils/app_colors.dart';
import 'game_result_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String selectedOption = '';
  late Timer timer;
  late Timer gameTimer;
  int correctCount = 0;
  int wrongCount = 0;
  int elapsedSeconds = 0;
  AudioPlayer audioPlayer = AudioPlayer();


  @override
  void initState() {
    super.initState();
    startQuestionTimer();
    startGameTimer();
    playSong();
    //moveToNextQuestion();
  }

  void playSong() async {
    audioPlayer.play(AssetSource('quiz_sound.mp3'));
  }

  void startGameTimer() {
    gameTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsedSeconds++;
      });
    });
  }

  void startQuestionTimer() {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (t.tick == 10 && questionsProvider.currentIndex < dummyQuestions.length - 1) {
        // Timer completed, move to the next question
        if (selectedOption.isEmpty && mounted) {
          // No option selected, increment wrongCount and move to the next question
          wrongCount++;
          moveToNextQuestion();
        }
      } else if (questionsProvider.currentIndex >= dummyQuestions.length - 1) {
        // Stop the timer when all questions are answered
        cancelTimer();
      }
    });
  }


  void handleOptionSelected(String selectedOption) {
    cancelTimer(); // Cancel the current timer

    setState(() {
      this.selectedOption = selectedOption;
    });

    // Move to the next question after a one sec delay
    Future.delayed(Duration(seconds: 1), () {
      moveToNextQuestion();
      startQuestionTimer(); // Start a new timer for the next question
    });
  }

  void cancelTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
  }


  void onRestart(BuildContext context) {
    // Reset necessary variables when restarting the game
    setState(() {
      correctCount = 0;
      wrongCount = 0;
      selectedOption = '';
      elapsedSeconds = 0;
    });

    // Reset question index to 0
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    questionsProvider.resetQuestionIndex(); // Make sure this line is here

    // Print debug statement
    print('Question index after reset: ${questionsProvider.currentIndex}');

    // Reset timers
    cancelTimer();
    startQuestionTimer();
    startGameTimer();
  }


  @override
  void dispose() {
    gameTimer.cancel();
    timer.cancel();
    audioPlayer.dispose();
    super.dispose();
  }


  void moveToNextQuestion() {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);

    if (selectedOption.isNotEmpty) {
      // If an option is selected, check if it's correct and update counts
      final currentQuestion = dummyQuestions[questionsProvider.currentIndex];
      final isCorrect = checkIfOptionIsCorrect(selectedOption, currentQuestion.options);

      if (isCorrect) {
        onAnsweredCorrectly(true);
      } else {
        onAnsweredWrongly(false);
      }

      selectedOption = ''; // Reset selected option
    }

    if (questionsProvider.currentIndex < dummyQuestions.length - 1) {
      // Move to the next question
      questionsProvider.moveToNextQuestion();
      startQuestionTimer(); // Reset the countdown for the next question
    } else {
      // If there are no more questions, stop the game timer
      cancelTimer();
      // Navigate to GameResult with correct counts
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameResult(
            correctCount: correctCount,
            wrongCount: wrongCount,
            elapsedSeconds: elapsedSeconds,
          ),
        ),
      );
    }
  }


  bool checkIfOptionIsCorrect(String selectedOption, List<QuestionOption> options) {
    return options.firstWhere((option) => option.text == selectedOption).isCorrect;
  }



  String formatTime(int seconds) {
    // Format elapsed seconds as per your requirement
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }


  void onAnsweredCorrectly(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        correctCount++;
      });
    }
  }

  void onAnsweredWrongly(bool isCorrect) {
    if (!isCorrect) {
      setState(() {
        wrongCount++;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    final questionsProvider = Provider.of<QuestionsProvider>(context);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 69,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(),
                                  child: Stack(
                                    children: [
                                      // Replace this with your desired alarm icon
                                      Icon(Icons.alarm, color: Colors.white),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 8), // Adjust the spacing as needed
                                TextSize14(
                                  text: formatTime(elapsedSeconds),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),


                    Container(
                      width: 60,
                      child: Center(
                        child: CircularCountdown(
                          key: ValueKey(questionsProvider.currentIndex),
                          duration: 10,
                          onCountdownComplete: () {
                            // Timer completed independently, move to the next question
                            moveToNextQuestion();
                            //startTimer(); // Start a new timer for the next question
                          },
                        ),
                      ),
                    ),


                    Container(
                      width: 60,
                    )
                  ],
                ),
              ),

              SizedBox(height: 33,),

          Container(
            width: 382,
            height: 182,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 8,
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
                )
              ],
            ),

            child: Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextSize20(
                        text: 'Question ${questionsProvider.currentIndex + 1}',
                        color: Colors.black,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 336,
                        child: TextSize16(
                          text: '${dummyQuestions[questionsProvider.currentIndex].question}',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
          ),


              SizedBox(height: 51,),

              SizedBox(
                child: TextSize18(
                  text: 'Choose Correct Option',
                ),
              ),

              SizedBox(height: 12,),

              Expanded(
                child: ListView.builder(
                  itemCount: dummyQuestions[questionsProvider.currentIndex].options.length,
                  itemBuilder: (context, index) {
                    final label = String.fromCharCode('A'.codeUnitAt(0) + index);
                    final option = dummyQuestions[questionsProvider.currentIndex].options[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomListItem(
                        option: option.text,  // Pass the correct option
                        answer: '',
                        isCorrect: option.isCorrect,
                        onSelect: (String selectedOption) {
                          handleOptionSelected(selectedOption);
                        },
                        isSelected: selectedOption == option.text,
                        onAnsweredCorrectly: onAnsweredCorrectly,
                        onAnsweredWrongly: onAnsweredWrongly,
                        label: label,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bool checkIfOptionIsCorrect(String option, String correctAnswer) {
  //   return option == correctAnswer;
  // }
}



class CustomListItem extends StatefulWidget {
  final String label;
  final String option;
  final String answer;
  final bool isCorrect;
  final bool isSelected;
  final Function(String) onSelect;
  final Function(bool) onAnsweredCorrectly;
  final Function(bool) onAnsweredWrongly;

  CustomListItem({
    required this.label,
    required this.option,
    required this.answer,
    required this.isCorrect,
    required this.isSelected,
    required this.onSelect,
    required this.onAnsweredCorrectly,
    required this.onAnsweredWrongly,
  });

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  void checkAnswer() {
    if (widget.isSelected) {
      if (widget.isCorrect) {
        widget.onAnsweredCorrectly(true);
      } else {
        widget.onAnsweredWrongly(false);
      }
    }
  }

  void moveToNextQuestion(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    questionsProvider.moveToNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(widget.option);
        checkAnswer();
        if (widget.isSelected) {
          moveToNextQuestion(context);
        }
      },
      child: Container(
        width: 373,
        height: 66,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: ShapeDecoration(
          color: widget.isSelected
              ? widget.isCorrect
              ? Color(0xFF009028) // Selected option is correct
              : Color(0xFFC30012) // Selected option is wrong
              : Color(0xFFF9F9F9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 4.02,
              color: widget.isSelected
                  ? widget.isCorrect
                  ? Color(0xFF00EA62) // Selected option is correct
                  : Color(0xFFF69798) // Selected option is wrong
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(100.57),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.isSelected ? Colors.white : Color(0xFF1B1B1B),
                      fontSize: 18,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 24), // Adjust spacing between label and option
                  Text(
                    widget.option,
                    style: TextStyle(
                      color: widget.isSelected
                          ? widget.isCorrect
                          ? Colors.white // Selected option is correct
                          : Color(0xFF1B1B1B) // Selected option is wrong
                          : Color(0xFF1B1B1B),
                      fontSize: 16,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    widget.answer,
                    style: TextStyle(
                      color: widget.isSelected ? Colors.white : Color(0xFF1B1B1B),
                      fontSize: 16,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (widget.isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(),
                child: widget.isSelected
                    ? widget.isCorrect
                    ? SvgPicture.asset('assets/correct.svg')
                    : SvgPicture.asset('assets/cancel.svg')
                    : SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }
}
