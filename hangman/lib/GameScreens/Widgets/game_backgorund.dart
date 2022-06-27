// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class GameBackGround extends StatelessWidget {
  const GameBackGround({Key? key, required this.secretWord}) : super(key: key);
  final secretWord;

  @override
  Widget build(BuildContext context) {
    if (secretWord == 'mal emir bunu bulamaz') {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/cat.gif'),
          ),
        ),
      );
    } else {
      return const Text('');
    }
  }
}
