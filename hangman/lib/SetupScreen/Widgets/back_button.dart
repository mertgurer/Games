import 'package:flutter/material.dart';

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Back'),
    );
  }
}
