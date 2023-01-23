import 'package:flutter/material.dart';

import '../../HomePage/menu.dart';

class RetrunButton extends StatelessWidget {
  const RetrunButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.black,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: const Icon(Icons.keyboard_backspace),
    );
  }
}
