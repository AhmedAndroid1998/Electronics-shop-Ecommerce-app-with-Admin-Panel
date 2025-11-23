import 'package:electronics_store_e_commerce_with_admin_panel/pages/category_products_screen.dart';
import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  final String imageName;
  final String category;

  const CategoryListTile(
      {required this.imageName, required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategoryProductsScreen(category: category)));
      },
      child: Container(
        width: 90,
        height: 120,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageName,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            Text(category),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
