import 'package:flutter/material.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Button(name: 'Versus'),
          Button(name: 'AI'),
          Button(name: 'Exit'),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String name;

  const Button({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 150),
      child: ElevatedButton(
        onPressed: null,
        child: Text(name),
      ),
    );
  }
}

class MenuLogo extends StatelessWidget {
  const MenuLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: const Text(
        'Hangman',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
      ),
    );
  }
}
