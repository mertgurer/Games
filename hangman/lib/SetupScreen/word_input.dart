// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'Widgets/back_button.dart';
import 'Widgets/send_button.dart';

class WordInput extends StatelessWidget {
  static var textInput = TextEditingController();

  const WordInput({Key? key}) : super(key: key);

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
              controller: textInput,
              decoration: InputDecoration(
                hintText: 'Secret word',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    textInput.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                BackHomeButton(),
                Spacer(),
                SendButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
