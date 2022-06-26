import 'package:flutter/material.dart';

import '../../SetupScreen/word_input.dart';

class GameButton extends StatelessWidget {
  final String name;

  const GameButton({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 150),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade300,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WordInput()),
          );
        },
        child: Text(name),
      ),
    );
  }
}
