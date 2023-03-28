// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:math';

import '../../GameScreens/game.dart';

class CategoryButton extends StatelessWidget {
  final String name;
  final List<dynamic> words;
  const CategoryButton({Key? key, required this.name, required this.words})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        pick_category(context, name, words);
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(135, 0),
          backgroundColor: Colors.blue.shade300,
          foregroundColor: Colors.black),
      child: Text(name),
    );
  }

  Future<void> pick_category(
      BuildContext context, String name, List<dynamic> words) async {
    var rng = Random();

    // pick a word and send it to the game
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Game(
              secret_word: words[rng.nextInt(words.length)].toLowerCase())),
    );
  }
}
