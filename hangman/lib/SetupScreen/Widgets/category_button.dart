// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../../GameScreens/game.dart';

class CategoryButton extends StatelessWidget {
  final String name;
  final int pick;
  const CategoryButton({Key? key, required this.name, required this.pick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        pick_category(context, pick);
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 0),
          primary: Colors.blue.shade300,
          onPrimary: Colors.black),
      child: Text(name),
    );
  }

  Future<void> pick_category(BuildContext context, int pick) async {
    var rng = Random();
    var start = 0;
    List<String> words = [];
    String word_file = '';

    // pick which file to read from
    if (pick == 0) {
      word_file = await rootBundle.loadString('assets/word_bank/movies.txt');
    } else if (pick == 1) {
      word_file = await rootBundle.loadString('assets/word_bank/tv.txt');
    } else if (pick == 2) {
      word_file = await rootBundle.loadString('assets/word_bank/actors.txt');
    } else if (pick == 3) {
      word_file = await rootBundle.loadString('assets/word_bank/supers.txt');
    } else if (pick == 4) {
      word_file = await rootBundle.loadString('assets/word_bank/sports.txt');
    } else if (pick == 5) {
      word_file = await rootBundle.loadString('assets/word_bank/animals.txt');
    } else if (pick == 6) {
      word_file = await rootBundle.loadString('assets/word_bank/cities.txt');
    }

    // transfer file strig info to a string list
    for (int i = 0; i < word_file.length; i++) {
      if (word_file[i] == '"') {
        start = i + 1;

        do {
          i++;
        } while (word_file[i] != '"');

        words.add(word_file.substring(start, i));
      }
    }

    // pick a word and send it to the game
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Game(
              secret_word: words[rng.nextInt(words.length)].toLowerCase())),
    );
  }
}
