// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

import '../EndScreens/win.dart';
import '../EndScreens/lose.dart';
import 'Widgets/hint_box_select.dart';
import 'Widgets/top_bar.dart';

class Game extends StatefulWidget {
  final String secret_word;
  late List<bool> letter_info;
  static late List<String> letters;
  static late List<String> used_letters;
  static late int lifes;
  static final guess_input = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(),
              Image(
                image: AssetImage('assets/zuko.jpg'),
                height: 200,
                width: 200,
              ),
              HintBoxSelect(Game.letters, widget.letter_info),
              // input field
              Row(
                children: [
                  Expanded(
                    // text field
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(70, 20, 15, 0),
                      child: TextField(
                        controller: Game.guess_input,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Guess a letter',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    // confirm button
                    padding: const EdgeInsets.fromLTRB(15, 20, 70, 0),
                    child: FloatingActionButton(
                      onPressed: () {
                        _guess = Game.guess_input.text;
                        Game.guess_input.clear();
                        if (_guess != '') {
                          check_letter(_guess, Game.letters);
                          check_game(Game.letters);
                        }
                      },
                      backgroundColor: Colors.blue.shade200,
                      child: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
      if (guess.contains(RegExp(r'^[A-Za-zğüçöış]+$'))) {
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
      if (letters[i].contains(RegExp(r'^[A-Za-zğüçöış]+$'))) {
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
