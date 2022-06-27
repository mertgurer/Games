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
          //fixedSize: const Size(50, 30),
          primary: Colors.blue.shade300,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          next(context);
        },
        child: Text(name),
      ),
    );
  }
}
