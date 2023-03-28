import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Widgets/back_button_2.dart';
import 'Widgets/category_button.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({Key? key}) : super(key: key);

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  bool loading = true;
  var categoryData = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryData();
  }

  void fetchCategoryData() async {
    final db = FirebaseFirestore.instance;

    await db.collection("Categories").get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        categoryData.add(docSnapshot.data());
      }

      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < categoryData.length; i++)
                      CategoryButton(
                          name: categoryData[i]["title"],
                          words: categoryData[i]["words"]),
                    const BackHomeButton2(),
                  ]),
            ),
          ),
        ),
      );
    }
  }
}
