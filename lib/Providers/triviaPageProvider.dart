import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TriviaPageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  BuildContext context;

  final int _maxQuestions = 10;
  final String _difficulty = "easy";
  final String _questionType = "multiple";

  List? questions;

  int currentQuestion = 0;
  int score = 0;

  String answerState = "none";

  TriviaPageProvider({required this.context}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        "amount": _maxQuestions,
        "difficulty": _difficulty,
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
    List answers = [];
    answers.add(questions![currentQuestion]["correct_answer"]);
    answers.addAll(questions![currentQuestion]["incorrect_answers"]);
    // TODO answers keeps shuffling after clicking on answer
    answers.shuffle();
    return answers;
  }

  void answerQuestion(String answer) async {
    bool isCorrect = questions![currentQuestion]["correct_answer"] == answer;
    if (isCorrect) {
      answerState = "correct";
    } else {
      answerState = "incorrect";
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => jumpToNextQuestion());
    notifyListeners();
  }

  void jumpToNextQuestion() {
    currentQuestion++;
    answerState = "none";
    notifyListeners();
  }
}
