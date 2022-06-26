// ignore_for_file: non_constant_identifier_names, must_be_immutable

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
        word = WordInput.textInput.text;
        WordInput.textInput.clear();
        if (word != '') {
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
