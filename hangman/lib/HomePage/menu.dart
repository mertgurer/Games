// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:hangman/SetupScreen/category_input.dart';
import '../SetupScreen/word_input.dart';
import 'Widgets/game_button.dart';
import 'Widgets/menu_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuLogo(),
            const GameButton(name: 'Play', next: get_word),
            const GameButton(name: 'Solo', next: get_category),
          ],
        ),
      ),
    );
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
