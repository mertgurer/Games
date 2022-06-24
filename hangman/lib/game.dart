// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final String secret_word;
  const Game({Key? key, required this.secret_word}) : super(key: key);

  @override
  State<Game> createState() => _GameState(secret_word);
}

class _GameState extends State<Game> {
  final String secret_word;
  var first = true;
  var index = -1;
  var _guess = TextEditingController();

  _GameState(this.secret_word);

  @override
  Widget build(BuildContext context) {
    List<String> letters = secret_word.split('');
    var letter_info =
        List<bool>.generate(secret_word.length, (int index) => false);
    index = -1;

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('hanging man'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...(letters).map((c) {
                  index++;
                  if (c.contains(RegExp(r'[A-Za-z]'))) {
                    if (first) {
                      first = false;
                      if (letter_info[index]) return Square(c: c.toUpperCase());
                    } else {
                      if (letter_info[index]) return Square(c: c.toLowerCase());
                    }
                  } else {
                    first = true;
                    return Empty(c: c);
                  }
                  return const Square(c: '');
                }).toList()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('hi'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  final String c;
  const Square({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 48,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        border: const Border(
          left: BorderSide(
            color: Colors.white,
            width: 3,
          ),
          right: BorderSide(
            color: Colors.white,
            width: 3,
          ),
          top: BorderSide(
            color: Colors.white,
            width: 3,
          ),
          bottom: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
      alignment: AlignmentDirectional.center,
      child: Text(
        c,
        style: const TextStyle(fontSize: 33),
      ),
    );
  }
}

class Empty extends StatelessWidget {
  final String c;
  const Empty({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 25,
      alignment: AlignmentDirectional.center,
      child: Text(
        c,
        style: const TextStyle(fontSize: 33),
      ),
    );
  }
}
