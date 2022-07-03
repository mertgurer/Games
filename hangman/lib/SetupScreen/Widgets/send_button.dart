// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:hangman/SetupScreen/word_input.dart';
import '../../GameScreens/game.dart';

class SendButton extends StatelessWidget {
  String word = '';
  SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade300, onPrimary: Colors.black),
      onPressed: () {
        if (WordInput.flag) {
          word = WordInput.textInput.text;
          word = word.trim();

          WordInput.textInput.clear();
          WordInput.flag = false;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Game(secret_word: word.toLowerCase()),
            ),
          );
        }
      },
      child: const Text('Lock Secret Word'),
    );
  }
}
