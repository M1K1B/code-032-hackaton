import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Category extends StatelessWidget {
  final String categoryName;

  const Category({required this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(categoryName),
    );
  }
}
