// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hangman/end.dart';
import 'package:hangman/win.dart';

class Game extends StatefulWidget {
  final String secret_word;
  late List<bool> letter_info;
  late List<String> letters;
  var lifes = 7;
  var found = false;

  Game({Key? key, required this.secret_word}) : super(key: key) {
    letter_info = List<bool>.generate(secret_word.length, (int index) => false);
    letters = secret_word.split('');
  }

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var first = true;
  var index = -1;
  String _guess = '';

  final _guess_input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    first = true;
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
                ...(widget.letters).map((c) {
                  index++;
                  if (c.contains(RegExp(r'[A-Za-z]'))) {
                    if (first) {
                      first = false;
                      if (widget.letter_info[index]) {
                        return Square(c: c.toUpperCase());
                      }
                    } else {
                      if (widget.letter_info[index]) {
                        return Square(c: c.toLowerCase());
                      }
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
                        border: UnderlineInputBorder(),
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
                      if (_guess != '' &&
                          (_guess.toLowerCase() == widget.secret_word ||
                              _guess.contains(RegExp(r'^[A-Za-z]+$')))) {
                        check_letter(_guess, widget.letters);
                        check_game(widget.letters);
                      }
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

  // checks if the guess is valid and proccesses it
  List<bool> check_letter(String guess, List<String> letters) {
    var word = widget.secret_word;
    // if the guess is the whole name
    if (guess.length > 1) {
      if (guess.toLowerCase() == widget.secret_word.toLowerCase()) {
        widget.found = true;
      } // if whole word guess is wrong
      else {
        widget.lifes--;
      }
    } // if the guess is a single letter
    else if (word.contains(guess)) {
      for (int i = 0; i < letters.length; i++) {
        if (letters[i].toLowerCase() == guess.toLowerCase()) {
          setState(() {
            widget.letter_info[i] = true;
          });
        }
      }
    } // if the letter guess is wrong
    else {
      widget.lifes--;
    }
    return widget.letter_info;
  }

  // checks if the game is over
  void check_game(List<String> letters) {
    if (widget.found) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Win(word: widget.secret_word)),
      );
    } else if (widget.lifes <= 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => End(word: widget.secret_word)),
      );
    }
    for (int i = 0; i < letters.length; i++) {
      if (letters[i].contains(RegExp(r'^[A-Za-z]+$'))) {
        if (widget.letter_info[i] == false) {
          return;
        }
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Win(word: widget.secret_word)),
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
