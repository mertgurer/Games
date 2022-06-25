// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

import './word_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var easter_egg = 'Hangman';

  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                counter++;
                print(counter);
                if (counter == 20) {
                  setState(() {
                    easter_egg = 'hangmang';
                  });
                }
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: MenuLogo(easter_egg: easter_egg)),
          const GameButton(name: 'Play'),
        ],
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String name;

  const GameButton({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 150),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade300,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordInput()),
          );
        },
        child: Text(name),
      ),
    );
  }
}

class MenuLogo extends StatelessWidget {
  final String easter_egg;
  const MenuLogo({Key? key, required this.easter_egg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Text(
        easter_egg,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
      ),
    );
  }
}
