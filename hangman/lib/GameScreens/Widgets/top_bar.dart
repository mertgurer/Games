import 'package:flutter/material.dart';

import '../game.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // top bar
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Row(
        children: [
          // heart info
          Icon(
            Icons.heart_broken_rounded,
            size: 30,
            color: Colors.red.shade900,
          ),
          Text(
            ' ${Game.lifes}',
            style: const TextStyle(fontSize: 21),
          ),
          // used letters
          const Spacer(),

          ...(Game.used_letters).map((l) {
            if (l != '') {
              l = '$l ';
            }
            return Text(
              l.toUpperCase(),
              style: const TextStyle(fontSize: 21),
            );
          }).toList(),

          const Padding(
            padding: EdgeInsets.fromLTRB(3, 0, 0, 3),
            child: Icon(
              Icons.block,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
