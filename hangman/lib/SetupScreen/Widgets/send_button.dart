// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

import 'package:hangman/SetupScreen/word_input.dart';
import '../../GameScreens/game.dart';

class SendButton extends StatelessWidget {
  String word = '';
  bool flag = true;
  SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade300, onPrimary: Colors.black),
      onPressed: () {
        word = WordInput.textInput.text;

        flag = inputCheck();
        if (flag) {
          WordInput.textInput.clear();
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

  bool inputCheck() {
    int word_count = 1;
    int start = 0;

    for (int i = 0; i < word.length; i++) {
      if (word[i] == ' ') {
        word_count++;
        if (i - start > 8) {
          return false;
        }
        start = i;
      } else if (i == word.length - 1) {
        if (i - start > 8) {
          return false;
        }
      }
    }

    if (word_count == 1 && word.length > 8) {
      return false;
    }

    if (word != '') {
      if (word_count <= 4) {
        return true;
      }
    }
    return false;
  }
}
