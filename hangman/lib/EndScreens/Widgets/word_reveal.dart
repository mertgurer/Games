// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class WordReveal extends StatelessWidget {
  String word;
  WordReveal({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String wordShort;
    String wordLong;

    if (word.length <= 25) {
      wordShort = allWordsCapitilize(word);
      wordLong = '';
    } else {
      wordShort = '';
      wordLong = allWordsCapitilize(word);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'The word was ',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: wordShort,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            wordLong,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String allWordsCapitilize(String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = word.substring(1, word.length);
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
