import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/Providers/triviaPageProvider.dart';

class TriviaPage extends StatefulWidget {
  TriviaPage({Key? key}) : super(key: key);

  @override
  _TriviaPageState createState() {
    return _TriviaPageState();
  }
}

class _TriviaPageState extends State<TriviaPage> {
  late double deviceHeight, deviceWidth;
  late TriviaPageProvider _triviaPageProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _triviaPageProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => TriviaPageProvider(context: context),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _triviaPageProvider = context.watch<TriviaPageProvider>();
      if (_triviaPageProvider.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: deviceHeight,
              width: deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        _answersButtons(),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _triviaPageProvider.getCurrentQuestionText(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: deviceHeight * 0.04,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _answersButtons() {
    List shuffledAnswersList = _triviaPageProvider.getCurrentQuestionAnswers();
    shuffledAnswersList.shuffle();
    return SizedBox(
      width: deviceWidth,
      height: deviceHeight * 0.4,
      child: GridView.builder(
        itemCount: shuffledAnswersList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: deviceHeight * 0.1,
          maxCrossAxisExtent: deviceWidth * 0.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return MaterialButton(
            onPressed: () {
              _triviaPageProvider.answerQuestion(shuffledAnswersList[index]);
            },
            color: Colors.grey,
            child: Text(
              shuffledAnswersList[index],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: deviceHeight * 0.025,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
