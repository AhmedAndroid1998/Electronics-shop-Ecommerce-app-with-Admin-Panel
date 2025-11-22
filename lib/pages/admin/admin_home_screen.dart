import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Home Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Add a Product'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
