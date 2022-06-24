// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hangman/end.dart';
import 'package:hangman/menu.dart';

class Game extends StatefulWidget {
  final String secret_word;
  const Game({Key? key, required this.secret_word}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var lives = 7;
  var first = true;
  var index = -1;
  final _guess_input = TextEditingController();
  String _guess = '';

  void check_letter(String guess) {
    var word = widget.secret_word;
    if (word.contains(guess)) {
    } else {
      lives--;
      print(lives);
    }
    if (lives <= 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const End()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> letters = widget.secret_word.split('');
    var letter_info =
        List<bool>.generate(widget.secret_word.length, (int index) => true);
    index = -1;
    first = true;

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
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(110, 70, 10, 0),
                    child: TextField(
                      controller: _guess_input,
                      decoration: const InputDecoration(
                        hintText: 'Guess a letter',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 70, 30, 10),
                  child: FloatingActionButton(
                    onPressed: () {
                      _guess = _guess_input.text;
                      _guess_input.clear();
                      check_letter(_guess);
                    },
                    backgroundColor: Colors.blue.shade200,
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                )
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
