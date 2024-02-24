import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game/provider/questions_provider.dart';
import 'package:trivia_game/screens/get_started_screen.dart';
import 'package:trivia_game/service/api_service.dart';

import 'network/QuestionsModel.dart';

Future<void> main() async {
  runApp(const MyApp());

  //QuestionsApiService apiService = QuestionsApiService();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));

  // try {
  //   print('Fetching questions...');
  //   List<QuestionsModel> questions = await apiService.getQuestions();
  //   print('Questions fetched successfully:');
  //   print(questions);
  // } catch (e) {
  //   print('Error: $e');
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionsProvider(),
      child: MaterialApp(
        title: 'Trivia Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: GetStartedScreen(),
      ),
    );
  }
}
