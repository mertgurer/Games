// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MenuLogo extends StatefulWidget {
  static var counter = 0;
  static var easter_egg = 'Hangman';

  MenuLogo({Key? key}) : super(key: key) {
    counter = 0;
    easter_egg = 'Hangman';
  }

  @override
  State<MenuLogo> createState() => _MenuLogoState();
}

class _MenuLogoState extends State<MenuLogo> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        MenuLogo.counter++;
        if (MenuLogo.counter >= 20) {
          setState(() {
            MenuLogo.easter_egg = 'hangmang';
          });
        }
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        splashFactory: NoSplash.splashFactory,
        enableFeedback: false,
        mouseCursor:
            MaterialStateProperty.all<MouseCursor>(SystemMouseCursors.basic),
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.blue.shade100),
      ),
      child: LogoText(easter_egg: MenuLogo.easter_egg),
    );
  }
}

class LogoText extends StatelessWidget {
  final String easter_egg;
  const LogoText({Key? key, required this.easter_egg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Text(
        easter_egg,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
      ),
    );
  }
}
