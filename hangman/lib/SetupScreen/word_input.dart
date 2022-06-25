// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../GameScreens/game_short.dart';

class WordInput extends StatelessWidget {
  WordInput({Key? key}) : super(key: key);

  final _textInput = TextEditingController();
  String _secret_word = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textInput,
              decoration: InputDecoration(
                hintText: 'Secret word',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _textInput.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _secret_word = _textInput.text;
                    _textInput.clear();
                    if (_secret_word != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Game(secret_word: _secret_word.toLowerCase()),
                        ),
                      );
                    }
                  },
                  child: const Text('Lock Secret Word'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
