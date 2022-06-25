import 'package:flutter/material.dart';

class WordReveal extends StatelessWidget {
  final String word;
  const WordReveal({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'The word was ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            allWordsCapitilize(word),
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
