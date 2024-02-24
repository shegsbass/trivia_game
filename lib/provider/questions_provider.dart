import 'package:flutter/cupertino.dart';
import 'package:trivia_game/network/QuestionsModel.dart';

class QuestionsProvider extends ChangeNotifier {
  late List<QuestionsModel> _questions = dummyQuestions;
  int _currentIndex = 0;
  late int _countdownDuration = 10;
  int get countdownDuration => _countdownDuration;

  List<QuestionsModel> get questions => _questions;
  int get currentIndex => _currentIndex;

  void moveToNextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void resetCountdown() {
    _countdownDuration = 10;
    notifyListeners();
  }

  void resetQuestionIndex() {
    print('Resetting question index');
    _currentIndex = 0;
    notifyListeners();
  }

}
