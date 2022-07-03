// ignore_for_file: non_constant_identifier_names, must_be_immutable, avoid_init_to_null

import 'package:flutter/material.dart';

import 'Widgets/back_button_1.dart';
import 'Widgets/send_button.dart';

class WordInput extends StatefulWidget {
  static var textInput = TextEditingController();
  static var message = null;
  static bool flag = false;

  const WordInput({Key? key}) : super(key: key);

  @override
  State<WordInput> createState() => _WordInputState();
}

class _WordInputState extends State<WordInput> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        WordInput.flag = inputCheck();
                      });
                    },
                    maxLength: 50,
                    controller: WordInput.textInput,
                    decoration: InputDecoration(
                      errorText: WordInput.message,
                      hintText: 'Secret word',
                      border: const OutlineInputBorder(),
                      counterText: '',
                      suffixIcon: IconButton(
                        onPressed: () {
                          WordInput.textInput.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const BackHomeButton1(),
                      const Spacer(),
                      SendButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool inputCheck() {
    var word = WordInput.textInput.text;
    int word_count = 1;
    int start = 0;

    word = word.trim();

    for (int i = 0; i < word.length; i++) {
      if (word[i] == ' ') {
        word_count++;
        if (i - start > 12) {
          WordInput.message = 'Maximum word length is 12 characters';
          return false;
        }
        start = i + 1;
      } else if (i == word.length - 1) {
        if (i - start > 12) {
          WordInput.message = 'Maximum word length is 12 characters';
          return false;
        }
      }
    }

    if (word_count == 1 && word.length > 12) {
      WordInput.message = 'Maximum word length is 12 characters';
      return false;
    }
    if (word == '') {
      WordInput.message = 'Can\'t be empty';
      return false;
    }
    if (word_count > 4) {
      WordInput.message = 'Maximum word count is 4 words';
      return false;
    }

    WordInput.message = null;
    return true;
  }
}
