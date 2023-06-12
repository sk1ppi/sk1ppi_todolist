import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Email controller
  final TextEditingController _emailController = TextEditingController();

  // Password contoller
  final TextEditingController _passwordController = TextEditingController();

  // Password confirm controller
  final TextEditingController _passwordConfirmController =
      TextEditingController();

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
              'Create a new account',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),

            // Spacing half
            const SizedBox(height: 10),

            // Already have an account
            Row(
              // Margin right
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () => {context.go('/')},
                  child: const Text('Sign in here.'),
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

            // Password confirm
            TextField(
              controller: _passwordConfirmController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm password',
              ),
            ),

            // Spacing
            const SizedBox(height: 20),

            // Button submit onPressed _submit()
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }

  // Future async function to submit the form
  Future<void> _submit() async {
    late Map data;

    // Get email and password
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String passwordConfirm = _passwordConfirmController.text;

    // Validate email and password
    if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
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

    // Validate password and passwordConfirm
    if (password != passwordConfirm) {
      // Show error dialog
      await showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match'),
        ),
      );

      return;
    }

    // TODO: Submit the form

    // POST to http://localhost:3000/user
    // using http package
    // https://pub.dev/packages/http

    // Try signing in
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await http
        .post(
          Uri.parse('http://localhost:3000/user'),
          body: {
            'email': email,
            'password': password,
          },
        )
        // assign decoded response to data
        .then((response) => data = jsonDecode(response.body))
        // catch error and show dialog response message error
        .catchError(
          (error) => {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error.toString()),
              ),
            ),
          },
        );

    // Save token to shared preferences
    await prefs.setString('token', data['token']);
  }
}
