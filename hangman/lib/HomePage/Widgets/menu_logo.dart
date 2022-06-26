// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hangman/HomePage/menu.dart';

class MenuLogo extends StatelessWidget {
  final void Function() press;
  const MenuLogo({Key? key, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: () {
          press();
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          splashFactory: NoSplash.splashFactory,
          enableFeedback: false,
          mouseCursor:
              MaterialStateProperty.all<MouseCursor>(SystemMouseCursors.basic),
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        child: LogoText(easter_egg: HomePage.easter_egg),
      ),
    );
  }
}

class LogoText extends StatelessWidget {
  final String easter_egg;
  const LogoText({Key? key, required this.easter_egg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      easter_egg,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
    );
  }
}
