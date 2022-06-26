import 'package:flutter/material.dart';

import '../../HomePage/menu.dart';

class RetrunButton extends StatelessWidget {
  const RetrunButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue.shade300,
        onPrimary: Colors.black,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      child: const Icon(Icons.keyboard_backspace),
    );
  }
}
