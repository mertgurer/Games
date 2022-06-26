import 'package:flutter/material.dart';

import 'Widgets/return_button.dart';
import 'Widgets/word_reveal.dart';

class Win extends StatelessWidget {
  final String word;
  const Win({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Congratulations!',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              WordReveal(word: word),
              const RetrunButton(),
            ],
          ),
        ),
      ),
    );
  }
}
