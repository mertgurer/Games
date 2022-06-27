import 'package:flutter/material.dart';

import 'Widgets/back_button_1.dart';
import 'Widgets/send_button.dart';

class WordInput extends StatelessWidget {
  static var textInput = TextEditingController();

  const WordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: TextField(
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
              ),
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
    );
  }
}
