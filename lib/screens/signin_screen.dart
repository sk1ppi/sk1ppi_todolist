import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Email controller
  final TextEditingController _emailController = TextEditingController();

  // Password contoller
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          // Center content
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),

          children: <Widget>[
            // Welcome text: bold cetnered
            const Text(
              'TodoList by SK1PPI',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),

            // Spacing half
            const SizedBox(height: 10),

            // Dont have an account
            Row(
              // Margin right
              children: <Widget>[
                const Text('Don\'t have an account?'),
                // Go
                TextButton(
                  onPressed: () => {
                    context.go('/signup'),
                  },
                  child: const Text('Sign up here.'),
                ),
              ],
            ),

            // Spacing
            const SizedBox(height: 20),

            // Email input
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),

            // Spacing
            const SizedBox(height: 20),

            // Password input
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),

            // Spacing
            const SizedBox(height: 20),

            // Button submit onPressed _submit()
            // Height the same as TextField
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  // Future async function to submit the form
  Future<void> _submit() async {
    // Get email and password
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Validate email and password
    if (email.isEmpty || password.isEmpty) {
      // Show error dialog
      await showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all fields'),
        ),
      );

      return;
    }
  }
}
