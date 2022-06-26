import 'package:flutter/material.dart';

import '../word_input.dart';

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        WordInput.textInput.clear();
      },
      child: const Text('Back'),
    );
  }
}
