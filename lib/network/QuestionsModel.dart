
import 'dart:developer';

import 'package:meta/meta.dart';
import 'dart:convert';

// class QuestionsModel {
//   final String question;
//   final List<String> options;
//   final String correctAnswer;
//
//   QuestionsModel({
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//   });
//
//   factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
//     question: json["question"],
//     options: List<String>.from(json["options"]),
//     correctAnswer: json["correctAnswer"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "question": question,
//     "options": options,
//     "correctAnswer": correctAnswer,
//   };
// }
//
// List<QuestionsModel>  questionsModelFromJson(String str) {
//   try {
//     List<dynamic> jsonData = json.decode(str);
//     return List<QuestionsModel>.from(jsonData.map((x) => QuestionsModel.fromJson(x)));
//   } catch (e,s) {
//     print('Error parsing JSON: $e');
//     print('Stack: $s');
//     throw Exception('Failed to load questions');
//   }
// }

class QuestionsModel {
  final String question;
  final List<QuestionOption> options;

  QuestionsModel({
    required this.question,
    required this.options,
  });
}

class QuestionOption {
  final String text;
  bool isSelected;
  bool isCorrect;

  QuestionOption({
    required this.text,
    this.isSelected = false,
    this.isCorrect = false,
  });
}


// Dummy Data
final List<QuestionsModel> dummyQuestions = [
  QuestionsModel(
    question: 'Who is known as the African Giant in the Nigerian music industry?',
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: true),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian artist won the 'Best International Act' at the 2020 BET Awards?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: true),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian musician collaborated with Drake on the hit song 'One Dance'?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: true),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Who is known as the 'Omo Baba Olowo' in the Nigerian music scene?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: true),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian female artist is known as the 'African Bad Gyal'?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: true),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian musician released the album 'Made in Lagos'?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: true),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian artist is the CEO of Starboy Entertainment?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: true),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian artist is known for hits like 'Fem' and 'If'?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: true),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Who won the 'Best New International Act' at the 2019 BET Awards?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: true),
      QuestionOption(text: 'Tiwa Savage', isCorrect: false),
    ],
  ),
  QuestionsModel(
    question: "Which Nigerian female artist collaborated with Beyoncé on the song 'Brown Skin Girl'?",
    options: [
      QuestionOption(text: 'Davido', isCorrect: false),
      QuestionOption(text: 'Wizkid', isCorrect: false),
      QuestionOption(text: 'Burna Boy', isCorrect: false),
      QuestionOption(text: 'Tiwa Savage', isCorrect: true),
    ],
  ),
];
