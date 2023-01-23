import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String name;
  final void Function(BuildContext context) next;

  const GameButton({Key? key, required this.name, required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 150),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade300,
          foregroundColor: Colors.black,
        ),
        onPressed: () {
          next(context);
        },
        child: Text(name),
      ),
    );
  }
}
