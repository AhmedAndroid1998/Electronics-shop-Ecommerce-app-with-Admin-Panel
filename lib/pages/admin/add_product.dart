import 'dart:io';

import 'package:electronics_store_e_commerce_with_admin_panel/services/firebase_storage_service.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/services/firestore_service.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/shared/utils.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final List<String> categories = ['Laptop', 'Phone', 'Tablet', 'Watch', 'Monitor'];

  String selectedCategory = '';

  File? selectedImage;

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Upload the Product Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (selectedImage == null)
                GestureDetector(
                  onTap: () async {
                    // TODO: Implement image picker
                    selectedImage = await pickImageFromGallery();
                    setState(() {});
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
                )
              else
                Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.fill,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                controller: _productNameController,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  border: OutlineInputBorder(),
                ),
                controller: _productPriceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product Details',
                  border: OutlineInputBorder(),
                ),
                controller: _productDetailsController,
                maxLines: 5,
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
                  onPressed: () async {
                    // TODO: Handle product submission
                    final imageUrl =
                        await FirebaseStorageService.uploadImageToFirebase(
                            imageFile: selectedImage!,
                            folder: selectedCategory,
                            imageName: _productNameController.text);
                    FirestoreService.addProduct(
                      category: selectedCategory,
                      productName: _productNameController.text,
                      imageUrl: imageUrl!,
                      productDetails: _productDetailsController.text,
                      price: double.parse(_productPriceController.text),
                    ).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Product has been uploaded successfully (:'),
                          backgroundColor: Colors.green));
                    });
                  },
                  child: Text(
                    'Add Product',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
