import 'package:electronics_store_e_commerce_with_admin_panel/pages/admin/admin_login_screen.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/pages/home_screen.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/services/firebase_auth_service.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  ///flag we use to render the appropriate page (signup/login)
  final bool isSignUp;

  const AuthScreen({super.key, this.isSignUp = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

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
                  if (widget.isSignUp) ...[
                    _buildInputField(
                        label: 'Name',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        }),
                    const SizedBox(height: 16),
                  ],
                  _buildInputField(
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
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
                  if (widget.isSignUp) ...[
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Confirm Password',
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                  if (!widget.isSignUp) ...[
                    const SizedBox(height: 8),
                    _buildForgotPassword(),
                  ],
                  const SizedBox(height: 16),
                  _buildActionButton(),
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
      height: 200,
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.isSignUp ? 'Sign Up' : 'Sign In',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.isSignUp
              ? 'Create your account by filling the details below.'
              : 'Please enter the details below to continue.',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
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

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password
        },
        child: const Text('Forgot Password?'),
      ),
    );
  }

  Widget _buildActionButton() {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: ElevatedButton(
        onPressed: () {
          //validate user input & authenticate to firebase
          _authenticate();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(widget.isSignUp ? 'SIGN UP' : 'LOGIN'),
      ),
    );
  }

  Widget _buildTogglePrompt(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.isSignUp
                ? 'Already have an account?'
                : "Don't have an account?"),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AuthScreen(isSignUp: !widget.isSignUp),
                  ),
                );
              },
              child: Text(widget.isSignUp ? 'Sign In' : 'Sign Up'),
            ),
          ],
        ),
        SizedBox(height: 20),
        OutlinedButton(
          style: TextButton.styleFrom(),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => AdminLoginScreen(),
              ),
            );
          },
          child: Text('Admin Login'),
        ),
      ],
    );
  }

  ///check if user input is valid & if so, authenticate(login/signup) to firebase
  void _authenticate() async {
    //check that the input is authenticated
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Proceed with login or signup logic
    final authService = AuthService();
    try {
      if (widget.isSignUp) {
        final name = nameController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text;
        final credential =
            await authService.signUp(name: name, email: email, password: password);

        //To prevent the warning error from the showSnackBar(): "Don't use 'BuildContext's across async gaps"
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Signing up...')));

        //Add this user to our firestore db
        await FirestoreService.createUserProfile(
            uid: credential!.user!.uid, name: name, email: email);
      } else {
        await authService.login(
            email: emailController.text.trim(), password: passwordController.text);

        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logging in...')));
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome, ${nameController.text}!'),
          backgroundColor: Colors.green,
        ),
      );

      //Navigate to home screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
