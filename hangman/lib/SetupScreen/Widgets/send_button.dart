// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hangman/SetupScreen/word_input.dart';

import '../../GameScreens/game_short.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (WordInput.textInput.text != '') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Game(secret_word: WordInput.textInput.text.toLowerCase()),
            ),
          );
        }
      },
      child: const Text('Lock Secret Word'),
    );
  }
}
