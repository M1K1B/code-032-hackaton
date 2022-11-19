import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackaton/data/categories.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;

  CategoryItem(this.categoryName, {super.key});

  @override
  Widget build(BuildContext context) {
    final cat = CATEGORIES.firstWhere(
        (element) => element['title'].toString().toUpperCase() == categoryName);

    return Container(
      child: Text(
        cat['title'].toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
          color: (cat['color'] as Color).withOpacity(0.7),
          border: Border.all(color: cat['color'] as Color, width: 1),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
