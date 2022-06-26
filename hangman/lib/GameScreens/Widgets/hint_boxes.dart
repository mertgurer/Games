// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

class HintBoxes extends StatelessWidget {
  var first = true;
  late int index_mark;
  late List<bool> letter_info;
  late List<String> letters;

  HintBoxes(this.letters, this.letter_info, this.index_mark, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    first = true;
    var index = index_mark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...(letters).map((c) {
            index++;
            if (c.contains(RegExp(r'[A-Za-zğüçöış]'))) {
              if (first) {
                first = false;
                if (letter_info[index]) {
                  return Square(c: c.toUpperCase());
                }
              } else {
                if (letter_info[index]) {
                  return Square(c: c.toLowerCase());
                }
              }
            } else {
              first = true;
              return Empty(c: c);
            }
            return const Square(c: '');
          }).toList()
        ],
      ),
    );
  }
}

class Square extends StatelessWidget {
  final String c;
  const Square({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 48,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        border: const Border(
          left: BorderSide(
            color: Colors.white,
            width: 3,
          ),
          right: BorderSide(
            color: Colors.white,
            width: 3,
          ),
          top: BorderSide(
            color: Colors.white,
            width: 3,
          ),
          bottom: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
      alignment: AlignmentDirectional.center,
      child: Text(
        c,
        style: const TextStyle(fontSize: 33),
      ),
    );
  }
}

class Empty extends StatelessWidget {
  final String c;
  const Empty({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 25,
      alignment: AlignmentDirectional.center,
      child: Text(
        c,
        style: const TextStyle(fontSize: 33),
      ),
    );
  }
}
