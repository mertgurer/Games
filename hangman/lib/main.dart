import 'package:flutter/material.dart';
import 'package:hangman/menu_button.dart';

void main() {
  runApp(Hangman());
}

class Hangman extends StatelessWidget {
  var menu_int = 0;

  Hangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hangman',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MenuLogo(),
          MenuButtons(),
        ],
      ),
    );
  }
}
