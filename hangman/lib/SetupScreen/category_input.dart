// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'Widgets/back_button_2.dart';
import 'Widgets/category_button.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CategoryButton(pick: 0, name: 'Movies'),
                  CategoryButton(pick: 1, name: 'Tv Shows'),
                  CategoryButton(pick: 2, name: 'Actors'),
                  CategoryButton(pick: 3, name: 'Heros / Villians'),
                  CategoryButton(pick: 4, name: 'Sports'),
                  CategoryButton(pick: 5, name: 'Animals'),
                  CategoryButton(pick: 6, name: 'Cities'),
                  BackHomeButton2(),
                ]),
          ),
        ),
      ),
    );
  }
}
