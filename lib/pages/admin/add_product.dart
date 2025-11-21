import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final List<String> categories = [
    'Laptop',
    'Phone',
    'Tablet',
    'Monitor',
    'Accessory',
  ];

  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Upload the Product Image',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // TODO: Implement image picker
              },
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Product Category',
                border: OutlineInputBorder(),
              ),
              // value: selectedCategory,
              items: categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 40),
            FractionallySizedBox(
              widthFactor: 0.3,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle product submission
                },
                child: Text(
                  'Add Product',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
