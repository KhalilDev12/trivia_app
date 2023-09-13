import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/Providers/triviaPageProvider.dart';

class TriviaPage extends StatefulWidget {
  int? category;
  late String difficulty;

  TriviaPage({required this.difficulty, required this.category, Key? key})
      : super(key: key);

  @override
  _TriviaPageState createState() {
    return _TriviaPageState();
  }
}

class _TriviaPageState extends State<TriviaPage> {
  late double deviceHeight, deviceWidth;
  late TriviaPageProvider _triviaPageProvider;
  late List answersList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => TriviaPageProvider(
        context: context,
        difficulty: widget.difficulty,
        category: widget.category,
      ),
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
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.04,
                  vertical: deviceHeight * 0.02),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _statsRow(),
        _questionText(),
        _answersButtons(),
        _exitButton(),
      ],
    );
  }

  Widget _statsRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Question:",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceHeight * 0.035,
              ),
            ),
            Text(
              "${_triviaPageProvider.currentQuestion+1}/10",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: deviceHeight * 0.03,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Score:",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceHeight * 0.035,
              ),
            ),
            Text(
              "${_triviaPageProvider.score}",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: deviceHeight * 0.03,
              ),
            ),
          ],
        )
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
    answersList = _triviaPageProvider.getCurrentQuestionAnswers();
    return SizedBox(
      width: deviceWidth,
      height: deviceHeight * 0.4,
      child: GridView.builder(
        itemCount: answersList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: deviceHeight * 0.1,
          maxCrossAxisExtent: deviceWidth * 0.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return MaterialButton(
            onPressed: () {
              _triviaPageProvider.answerQuestion(index);
            },
            color: _triviaPageProvider.listColors[index],
            child: Text(
              answersList[index],
              textAlign: TextAlign.center,
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

  Widget _exitButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.all(deviceHeight * 0.02),
        decoration:
            const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: deviceHeight * 0.04,
          ),
        ),
      ),
    );
  }
}
