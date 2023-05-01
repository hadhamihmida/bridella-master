import 'package:bridella/app_core/widgets/custom_app_bar.dart';
import 'package:bridella/business/screens/products_page.dart';
import 'package:flutter/material.dart';

import '../../app_core/services/constants.dart';

class CategoriesPage extends StatelessWidget {
  static String routeName = "/categories_page";
  CategoriesPage({Key? key}) : super(key: key);
  final List<String> categories = [
    "Beauty",
    "Furniture",
    "Smartphones",
    "cakes",
    "Fashion",
    "accessories",
    "Gifts",
    "Cars",
    "Services",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: 'Categories',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
                      children: categories
                          .map((String title) => buildCategorie(title, context))
                          .toList()))
            ],
          ),
        ),

        //bottom navigationb bar
      ),
    );
  }
}

Widget buildCategorie(String title, context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => BridellaProductsScreen(
                  catName: title,
                )),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: bridellaBGColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 2,
                offset: const Offset(2, 2))
          ]),
      child: Text(
        title,
      ),
    ),
  );
}
