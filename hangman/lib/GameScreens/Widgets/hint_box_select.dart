// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hangman/GameScreens/Widgets/hint_boxes.dart';

class HintBoxSelect extends StatelessWidget {
  late List<bool> letter_info;
  late List<String> letters;
  int word_count = 1;

  HintBoxSelect(this.letters, this.letter_info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < letters.length; i++) {
      if (letters[i] == ' ') {
        word_count++;
      }
    }
    // == 1 word inputs ==
    if (word_count == 1) {
      // 1 line
      if (letters.length <= 8) {
        return HintBoxes(letters, letter_info, -1);
      }
    }
    // == 2 word inputs ==
    else if (word_count == 2) {
      // 1line
      if (letters.length <= 8) {
        return HintBoxes(letters, letter_info, -1);
      }
      // 2 linesf
      else if (letters.length <= 17) {
        for (int i = 0; i < letters.length; i++) {
          if (letters[i] == ' ') {
            var line_1 = letters.sublist(0, i);
            var line_2 = letters.sublist(i + 1, letters.length);
            return Column(
              children: [
                HintBoxes(line_1, letter_info, -1),
                HintBoxes(line_2, letter_info, i)
              ],
            );
          }
        }
      }
    }
    // == 3 word inputs ==
    else if (word_count == 3) {
      // 1 line
      if (letters.length <= 8) {
        return HintBoxes(letters, letter_info, -1);
      }
      int first_space = -1;
      int second_space = -1;
      for (int i = 0; i < letters.length; i++) {
        if (letters[i] == ' ') {
          if (first_space == -1) {
            first_space = i;
          } else {
            second_space = i;
          }
        }
      }
      var line_1 = letters.sublist(0, first_space);
      var line_2 = letters.sublist(first_space + 1, second_space);
      var line_3 = letters.sublist(second_space + 1, letters.length);
      // 2 lines
      if (letters.length <= 18 &&
          (line_1.length + line_2.length <= 7 ||
              line_2.length + line_3.length <= 7)) {
        // if first 2 word are short
        if (line_1.length + line_2.length <= 7) {
          line_1 = letters.sublist(0, second_space);
          return Column(
            children: [
              HintBoxes(line_1, letter_info, -1),
              HintBoxes(line_3, letter_info, second_space)
            ],
          );
        }
        // if last 2 words are short
        else {
          line_3 = letters.sublist(first_space + 1, letters.length);
          return Column(
            children: [
              HintBoxes(line_1, letter_info, -1),
              HintBoxes(line_3, letter_info, first_space)
            ],
          );
        }
      }
      // 3 lines
      else if (letters.length <= 26) {
        return Column(
          children: [
            HintBoxes(line_1, letter_info, -1),
            HintBoxes(line_2, letter_info, first_space),
            HintBoxes(line_3, letter_info, second_space),
          ],
        );
      }
    }
    // == 4 word inputs ==
    else if (word_count == 4) {
      int first_space = -1;
      int second_space = -1;
      int third_space = -1;
      for (int i = 0; i < letters.length; i++) {
        if (letters[i] == ' ') {
          if (first_space == -1) {
            first_space = i;
          } else if (second_space == -1) {
            second_space = i;
          } else {
            third_space = i;
          }
        }
      }
      var line_1 = letters.sublist(0, first_space);
      var line_2 = letters.sublist(first_space + 1, second_space);
      var line_3 = letters.sublist(second_space + 1, third_space);
      var line_4 = letters.sublist(third_space + 1, letters.length);

      // 2 lines
      if (letters.length <= 17 &&
          line_1.length + line_2.length <= 7 &&
          line_3.length + line_4.length <= 7) {
        var line_1 = letters.sublist(0, second_space);
        var line_2 = letters.sublist(second_space + 1, letters.length);

        return Column(
          children: [
            HintBoxes(line_1, letter_info, -1),
            HintBoxes(line_2, letter_info, second_space),
          ],
        );
      }
      // 3 lines
      else if (letters.length <= 26 &&
          (line_1.length + line_2.length <= 7 ||
              line_2.length + line_3.length <= 7 ||
              line_3.length + line_4.length <= 7)) {
        // if first 2 words are short
        if (line_1.length + line_2.length <= 7) {
          line_1 = letters.sublist(0, second_space);
          return Column(
            children: [
              HintBoxes(line_1, letter_info, -1),
              HintBoxes(line_3, letter_info, second_space),
              HintBoxes(line_4, letter_info, third_space),
            ],
          );
        }
        // if middle 2 words are short
        if (line_2.length + line_3.length <= 7) {
          line_2 = letters.sublist(first_space + 1, third_space);
          return Column(
            children: [
              HintBoxes(line_1, letter_info, -1),
              HintBoxes(line_2, letter_info, first_space),
              HintBoxes(line_4, letter_info, third_space),
            ],
          );
        }
        // if last 2 words are short
        if (line_3.length + line_4.length <= 7) {
          line_3 = letters.sublist(second_space + 1, letters.length);
          return Column(
            children: [
              HintBoxes(line_1, letter_info, -1),
              HintBoxes(line_2, letter_info, first_space),
              HintBoxes(line_3, letter_info, second_space),
            ],
          );
        }
      }
      // 4 lines
      else if (letters.length <= 35) {
        return Column(
          children: [
            HintBoxes(line_1, letter_info, -1),
            HintBoxes(line_2, letter_info, first_space),
            HintBoxes(line_3, letter_info, second_space),
            HintBoxes(line_4, letter_info, third_space),
          ],
        );
      }
    }
    return const Text('Error');
  }
}
