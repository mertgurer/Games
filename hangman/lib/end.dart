import 'package:flutter/material.dart';

class End extends StatelessWidget {
  const End({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: const Center(
        child: Text('Game Over'),
      ),
    );
  }
}
