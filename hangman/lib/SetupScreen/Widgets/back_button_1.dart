import 'package:flutter/material.dart';

import '../word_input.dart';

class BackHomeButton1 extends StatelessWidget {
  const BackHomeButton1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        WordInput.textInput.clear();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue.shade300,
        onPrimary: Colors.black,
      ),
      child: const Text('Back'),
    );
  }
}
