import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:trivia_game/common/global.dart';
import 'package:trivia_game/config/api_config/api_url.dart';

import '../network/QuestionsModel.dart';
import '../provider/questions_provider.dart';
import 'exceptions.dart';
import 'package:http/http.dart' as http;

// class QuestionsApiService {
//   static const String apiUrl = 'https://qmtech.free.beeceptor.com/questions';
//   static const Duration _timeOutDuration = Duration(seconds: 120);
//
//   Future<void> getQuestions(QuestionsProvider questionsProvider) async {
//     try {
//       // Make a GET request using Dio
//       http.Response response = await http.get(Uri.parse(apiUrl));
//
//       // Check if the response body is null
//       if (response.body == null) {
//         print('Response body is null.');
//         throw Exception('Failed to load questions');
//       }
//
//       if (response.statusCode == 200) {
//         // Parse the response data
//         List<QuestionsModel> questionsList = questionsModelFromJson(
//             response.body.substring(response.body.indexOf("[")));
//         //return questionsList;
//
//         // Assuming you want to display the first question from the list
//         questionsProvider.getQuestions(
//           questionsList.first.question,
//           questionsList.first.options,
//           questionsList.first.correctAnswer,
//         );
//
//       } else {
//         print('Failed to load questions. Status code: ${response.statusCode}');
//         print('Response data: ${response.body}');
//         throw Exception('Failed to load questions');
//       }
//     } catch (e, s) {
//       print('Error occurred: $e');
//       print('Stack: $s');
//       throw Exception('Failed to load questions');
//     }
//   }
// }
