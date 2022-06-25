// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'Widgets/game_button.dart';
import 'Widgets/menu_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenuLogo(),
          const GameButton(name: 'Play'),
        ],
      ),
    );
  }
}
