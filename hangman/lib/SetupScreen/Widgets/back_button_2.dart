import 'package:flutter/material.dart';
import 'package:hangman/HomePage/menu.dart';

class BackHomeButton2 extends StatelessWidget {
  const BackHomeButton2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        HomePage.counter = 0;
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue.shade300,
        onPrimary: Colors.black,
      ),
      child: const Icon(Icons.arrow_back),
    );
  }
}
