import 'package:flutter/material.dart';

class TriviaPage extends StatefulWidget {
  TriviaPage({Key? key}) : super(key: key);

  @override
  _TriviaPageState createState() {
    return _TriviaPageState();
  }
}

class _TriviaPageState extends State<TriviaPage> {
  late double deviceHeight, deviceWidth;

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
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          width: deviceWidth,
          child: _gameUI(),
        ),
      ),
    );
  }

  Widget _gameUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      "Test Question 1, Nothing Interesting",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: deviceHeight * 0.04,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _answersButtons() {
    return GridView.builder(
      itemCount: 4,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            onTap: () {},
            child: Text(
              "Answer $index",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
