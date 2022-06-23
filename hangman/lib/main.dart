import 'package:flutter/material.dart';

import './menu.dart';

void main() {
  runApp(const Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hangman',
      home: HomePage(),
    );
  }
}
