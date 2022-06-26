import 'package:flutter/material.dart';
import 'package:hangman/GameScreens/game.dart';
import 'package:hangman/HomePage/menu.dart';

class HangingMan extends StatelessWidget {
  const HangingMan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (HomePage.easter_egg == 'hangmang') {
      return const Image(
        image: AssetImage('assets/zuko.jpg'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 7) {
      return const Image(
        image: AssetImage('assets/hanging/h0.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 6) {
      return const Image(
        image: AssetImage('assets/hanging/h1.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 5) {
      return const Image(
        image: AssetImage('assets/hanging/h2.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 4) {
      return const Image(
        image: AssetImage('assets/hanging/h3.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 3) {
      return const Image(
        image: AssetImage('assets/hanging/h4.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 2) {
      return const Image(
        image: AssetImage('assets/hanging/h5.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 1) {
      return const Image(
        image: AssetImage('assets/hanging/h6.png'),
        height: 150,
        width: 150,
      );
    } else if (Game.lifes == 0) {
      return const Image(
        image: AssetImage('assets/hanging/h7.png'),
        height: 150,
        width: 150,
      );
    }

    return const Text('error');
  }
}
