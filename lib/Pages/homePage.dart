import 'package:flutter/material.dart';
import 'package:trivia_app/Pages/triviaPage.dart';
import 'package:trivia_app/Providers/triviaPageProvider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double deviceWidth, deviceHeight;
  late TriviaPageProvider _triviaPageProvider;
  double _difficultyLvl = 0;
  List<String> difficulty = ["Easy", "Medium", "Hard"];

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

    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          width: deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleText(),
                Column(children: [
                  _difficultyText(),
                  SizedBox(height: deviceHeight * 0.02),
                  _difficultySlider(),
                ]),
                _startButton(),
              ]),
        ),
      ),
    );
  }

  Widget _titleText() {
    return Text(
      "Trivia App",
      style: TextStyle(
          color: Colors.white,
          fontSize: deviceHeight * 0.05,
          fontWeight: FontWeight.w500),
    );
  }

  Widget _difficultyText() {
    return Text(
      difficulty[_difficultyLvl.toInt()],
      style: TextStyle(
        color: Colors.white,
        fontSize: deviceHeight * 0.03,
      ),
    );
  }

  Widget _difficultySlider() {
    return Slider(
      label: "Difficulty",
      value: _difficultyLvl,
      onChanged: (value) {
        setState(() {
          _difficultyLvl = value;
        });
      },
      max: 2,
      min: 0,
      divisions: 2,
    );
  }

  Widget _startButton() {
    return MaterialButton(
      minWidth: deviceWidth * 0.6,
      height: deviceHeight * 0.08,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TriviaPage(
                difficulty: difficulty[_difficultyLvl.toInt()].toLowerCase()),
          ),
        );
      },
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(deviceHeight * 0.05)),
      child: Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: deviceHeight * 0.035,
        ),
      ),
    );
  }
}
