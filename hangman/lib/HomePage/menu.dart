// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:hangman/SetupScreen/category_input.dart';
import '../SetupScreen/word_input.dart';
import 'Widgets/backgroun.dart';
import 'Widgets/game_button.dart';
import 'Widgets/menu_logo.dart';

class HomePage extends StatefulWidget {
  static var counter = 0;
  static var easter_egg = 'Hangman';

  HomePage({Key? key}) : super(key: key) {
    counter = 0;
    easter_egg = 'Hangman';
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Stack(children: [
          BackGround(),
          Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuLogo(press: hidden_button),
                  const SizedBox(height: 50),
                  const GameButton(name: 'Play', next: get_word),
                  const GameButton(name: 'Solo', next: get_category),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void hidden_button() {
    HomePage.counter++;
    if (HomePage.counter >= 50) {
      setState(() {
        HomePage.easter_egg = 'hangmang';
      });
    }
  }
}

void get_word(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WordInput()),
  );
}

void get_category(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CategoryMenu()),
  );
}
