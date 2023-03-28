import 'package:flutter/material.dart';

class Signature extends StatelessWidget {
  const Signature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Image(
              image: AssetImage('assets/logo.png'),
              height: 69,
              width: 92,
            ),
          ],
        ),
      ),
    );
  }
}
