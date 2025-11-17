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
    required TextEditingController controller,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
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
          //check that the input is authenticated
          final isValid = _formKey.currentState?.validate() ?? false;
          if (isValid) {
            // Proceed with login or signup logic
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(widget.isSignUp ? 'Signing up...' : 'Logging in...')));
          }
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            widget.isSignUp ? 'Already have an account?' : "Don't have an account?"),
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
    );
  }
}
