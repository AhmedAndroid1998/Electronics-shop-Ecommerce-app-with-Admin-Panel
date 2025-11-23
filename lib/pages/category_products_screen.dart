import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/pages/product_details_screen.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/services/firestore_service.dart';
import 'package:flutter/material.dart';

import '../shared/styles.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;
  const CategoryProductsScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.getProducts(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error Loading Products'));
          }

          final products = snapshot.data?.docs ?? [];

          return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                final product = products[index].data() as Map<String, dynamic>;

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Expanded(
                        child: product['imageUrl'] == null
                            ? const Icon(
                                Icons.image,
                                size: 80,
                                color: Colors.grey,
                              )
                            : Image.network(product['imageUrl'], fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product['name'] ?? 'No name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$${product['price']}',
                            style: MyStyles.smallBoldTextFieldStyle()
                                .copyWith(color: Colors.deepOrange),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductDetailsScreen(
                                              name: product['name'],
                                              imageUrl: product['imageUrl'],
                                              details: product['details'],
                                              price: product['price'],
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                padding: EdgeInsets.zero, // Remove default padding
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16, // Adjust icon size to fit
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
