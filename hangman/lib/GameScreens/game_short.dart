// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hangman/LosePage/end.dart';
import 'package:hangman/WinPage/win.dart';

class Game extends StatefulWidget {
  final String secret_word;
  late List<bool> letter_info;
  late List<String> letters;
  static late List<String> used_letters;
  static late int lifes;
  var found = false;

  Game({Key? key, required this.secret_word}) : super(key: key) {
    letter_info = List<bool>.generate(secret_word.length, (int index) => false);
    letters = secret_word.split('');
    used_letters = List<String>.generate(7, (int index) => '');
    lifes = 7;
  }

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  String _guess = '';
  final _guess_input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(),
            HintBoxes(widget.letters, widget.letter_info),
            // input field
            Row(
              children: [
                Expanded(
                  // text field
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 70, 15, 0),
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
                  // confirm button
                  padding: const EdgeInsets.fromLTRB(15, 70, 70, 0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _guess = _guess_input.text;
                      _guess_input.clear();
                      if (_guess != '') {
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
      if (guess.toLowerCase() == word.toLowerCase()) {
        widget.found = true;
      } // if whole word guess is wrong
      else {
        if (guess.length != word.length) {
          return widget.letter_info;
        }
        setState(() {
          Game.lifes--;
        });
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
      for (int i = 0; i < 7; i++) {
        if (Game.used_letters[i] == guess) {
          return widget.letter_info;
        }
      }
      setState(() {
        Game.used_letters[7 - Game.lifes] = guess;
        Game.lifes--;
      });
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
    } else if (Game.lifes <= 0) {
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

class HintBoxes extends StatelessWidget {
  var first = true;
  var index = -1;
  late List<bool> letter_info;
  late List<String> letters;

  HintBoxes(this.letters, this.letter_info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    first = true;
    index = -1;

    return Row(
      // hint boxes
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...(letters).map((c) {
          index++;
          if (c.contains(RegExp(r'[A-Za-z]'))) {
            if (first) {
              first = false;
              if (letter_info[index]) {
                return Square(c: c.toUpperCase());
              }
            } else {
              if (letter_info[index]) {
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
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // top bar
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Row(
        children: [
          // heart info
          Icon(
            Icons.heart_broken_rounded,
            size: 30,
            color: Colors.red.shade900,
          ),
          Text(
            ' ${Game.lifes}',
            style: const TextStyle(fontSize: 21),
          ),
          // used letters
          const Spacer(),

          ...(Game.used_letters).map((l) {
            if (l != '') {
              l = '$l ';
            }
            return Text(
              l.toUpperCase(),
              style: const TextStyle(fontSize: 21),
            );
          }).toList(),

          const Padding(
            padding: EdgeInsets.fromLTRB(3, 0, 0, 3),
            child: Icon(
              Icons.block,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
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
