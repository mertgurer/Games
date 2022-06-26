import 'package:flutter/material.dart';

import 'package:hangman/HomePage/menu.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (HomePage.easter_egg == 'hangmang') {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/shrek.gif'),
          ),
        ),
      );
    } else {
      return const Text('');
    }
  }
}
