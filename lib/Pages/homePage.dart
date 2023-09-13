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
  List<String> categoryList = [
    "Any Category",
    "Books",
    "Films",
    "Music",
    "Video Games",
    "Sports",
    "Geography",
    "History",
  ]; // List of Categories
  List categoryCode = [
    null,
    10,
    11,
    12,
    15,
    21,
    22,
    23,
  ]; // List of Codes of Categories
  String _selectedCategory = "Any Category";
  int? _selectedCategoryCode;

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
                Column(
                  children: [
                    _difficultyText(),
                    _difficultySlider(),
                    SizedBox(height: deviceHeight * 0.02),
                    _categoryText(),
                    _categoryDropDown(),
                  ],
                ),
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
      "Choose the Difficulty:",
      style: TextStyle(
        color: Colors.white,
        fontSize: deviceHeight * 0.035,
      ),
    );
  }

  Widget _difficultySlider() {
    return Slider(
      label: difficulty[_difficultyLvl.toInt()],
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

  Widget _categoryText() {
    return Text(
      "Choose the Category:",
      style: TextStyle(
        color: Colors.white,
        fontSize: deviceHeight * 0.035,
      ),
    );
  }

  Widget _categoryDropDown() {
    return DropdownButton(
      value: _selectedCategory,
      iconEnabledColor: Colors.white,
      style: TextStyle(
          color: Colors.deepPurple,
          fontSize: deviceHeight * 0.03,
          fontFamily: "ArchitectsDaughter"),
      items: categoryList
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue!;
          int categoryIndex = categoryList.indexOf(newValue);
          _selectedCategoryCode = categoryCode[categoryIndex];
        });
      },
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
              difficulty: difficulty[_difficultyLvl.toInt()].toLowerCase(),
              category: _selectedCategoryCode,
            ),
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
