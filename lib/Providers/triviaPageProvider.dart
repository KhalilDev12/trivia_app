import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TriviaPageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  BuildContext context;

  final int _maxQuestions = 10;
  late String difficulty;

  final String _questionType = "multiple";

  List? questions; // List of Questions

  int currentQuestion = 0; // index of current question
  int score = 0; // Score

  List currentAnswers = []; // Answers of current question

  List<Color> listColors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  TriviaPageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        "amount": _maxQuestions,
        "difficulty": difficulty,
        "type": _questionType,
      },
    );

    var data = jsonDecode(response.toString());
    questions = data["results"];
    print(questions);
    notifyListeners();
  }

  String getCurrentQuestionText() {
    // Get The Question
    String question = questions![currentQuestion]["question"];
    // Replace the Special Characters
    String modifiedQuestion =
        question.replaceAll("&quot;", "\"").replaceAll("&#039;", "'");
    return modifiedQuestion;
  }

  List getCurrentQuestionAnswers() {
    if (currentAnswers.isEmpty) {
      currentAnswers.add(questions![currentQuestion]["correct_answer"]);
      currentAnswers.addAll(questions![currentQuestion]["incorrect_answers"]);
      currentAnswers.shuffle();
    }
    return currentAnswers;
  }

  void answerQuestion(int index) async {
    String chosenAnswer = currentAnswers[index]; // get the chosen answer
    bool isCorrect =
        questions![currentQuestion]["correct_answer"] == chosenAnswer;
    if (isCorrect) {
      listColors[index] = Colors.green;
      score++;
    } else {
      listColors[index] = Colors.red;
      int indexOfCorrectAnswer =
          currentAnswers.indexOf(questions![currentQuestion]["correct_answer"]);
      listColors[indexOfCorrectAnswer] = Colors.green;
    }
    Future.delayed(const Duration(seconds: 1))
        .then((value) => goToNextQuestion());
    notifyListeners();
  }

  void goToNextQuestion() {
    if (currentQuestion < 9) {
      currentQuestion++;
      listColors = [
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
      currentAnswers = [];
      notifyListeners();
    } else {
      endGame();
    }
  }

  void endGame() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          content: Text(
            "Your Score is: $score/$_maxQuestions",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
