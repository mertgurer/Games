import 'package:flutter/material.dart';

import 'HomePage/menu.dart';

void main() {
  runApp(const Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      home: HomePage(),
    );
  }
}



//  23.06.2022
//  27.06.2022
//  Mert Gürer
