import 'package:electronics_store_e_commerce_with_admin_panel/pages/admin/admin_home_screen.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/pages/auth_screen.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _buildImageSection(),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTitleSection(),
                  const SizedBox(height: 24),
                  _buildInputField(
                    label: 'Username',
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your username';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(context),
                  const SizedBox(height: 24),
                  _buildTogglePrompt(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Image.asset(
      'assets/images/login.jpg',
      height: 300,
    );
  }

  Widget _buildTitleSection() {
    return Text(
      'Admin Panel',
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInputField({
    required String label,
    TextInputType? keyboardType,
    required TextEditingController controller,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: ElevatedButton(
        onPressed: () {
          //validate user input & authenticate to firebase
          _login(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text('LOGIN'),
      ),
    );
  }

  Widget _buildTogglePrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("A regular user:"),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => AuthScreen(),
              ),
            );
          },
          child: Text('SignIn / Register'),
        ),
      ],
    );
  }

  ///check if user input is an authenticated admin
  void _login(BuildContext context) async {
    //check that the input is valid
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Proceed with getting data from our firestore db
    final username = usernameController.text.trim();
    final password = passwordController.text;

    print('Iam here ✅✅✅✅✅');
    await FirestoreService()
        .loginAdmin(username: username, password: password)
        .then((value) {
      if (value) {
        print('Iam here here ✅✅✅✅✅✅✅✅✅');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AdminHomeScreen()),
        );
      }
    });
  }
}
