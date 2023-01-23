import 'package:flutter/material.dart';
import 'package:hangman/HomePage/menu.dart';

import '../word_input.dart';

class BackHomeButton1 extends StatelessWidget {
  const BackHomeButton1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);

        WordInput.textInput.clear();
        WordInput.message = null;
        WordInput.flag = false;

        HomePage.counter = 0;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.black,
      ),
      child: const Text('Back'),
    );
  }
}
