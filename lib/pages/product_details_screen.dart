import 'package:electronics_store_e_commerce_with_admin_panel/shared/components.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../shared/styles.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HOME_PAGE_BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircledBackButton(context),
            Image.asset(
              'assets/images/headphones.jpg',
              width: double.infinity,
              height: 400,
              fit: BoxFit.fitWidth,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: HOME_PAGE_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader("Headphone", 300),
                        SizedBox(height: 20),
                        Text(
                          "Details",
                          style: MyStyles.smallBoldTextFieldStyle(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'This product is very good. It has 1 year warranty, these '
                          'They have a fashionable design',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                    _buildBuyButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String productName, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productName,
          style: MyStyles.boldTextFieldStyle(),
        ),
        Text(
          '\$$price',
          style: MyStyles.lightTextFieldStyle().copyWith(color: Colors.deepOrange),
        ),
      ],
    );
  }

  Widget _buildBuyButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          'BUY NOW',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
