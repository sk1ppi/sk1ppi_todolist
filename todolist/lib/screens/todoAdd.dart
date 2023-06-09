import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({super.key});

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new task'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Add a text field for task
          TextField(
            controller: _taskController,
            decoration: const InputDecoration(hintText: 'Enter a task'),
          ),

          // Add spacing between the text fields
          const SizedBox(height: 16.0),

          // Add a multiline text field for description
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(hintText: 'Enter a description'),
            minLines: 5,
            maxLines: 15,
            keyboardType: TextInputType.multiline,
          ),

          // Add spacing between the text fields and the button
          const SizedBox(height: 16.0),

          // Add a button to add a new task
          ElevatedButton(
            onPressed: submit,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void submit() async {
    final task = _taskController.text;
    final description = _descriptionController.text;

    if (task.isNotEmpty && description.isNotEmpty) {
      // Create a new task
      final body = {"title": task, "body": description, "userId": 1};

      // Show loading unclosable dialog
      // This is to prevent user from clicking the button multiple times
      // while waiting for the response from the server
      // This dialog will be closed after the response is received
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // POST to https://jsonplaceholder.typicode.com/ using await http.post
      // .catch if error display error snackbar and clear the text fields
      await http.post(Uri.parse('https://jsonplaceholder.typicode.com/postsr'),
              body: jsonEncode(body),
              headers: {
            "Content-type": "application/json; charset=UTF-8",
          })
          // .then if success close loading dialog and navigate back to the previous page
          .then((response) {
        Navigator.pop(context);
        Navigator.pop(context);
      })
          // .catch if error display error snackbar and clear the text fields
          .catchError((cerror) {
        // log error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: Please try again',
                style: TextStyle(color: Colors.white)),
          ),
        );

        // Close the loading dialog
        Navigator.pop(context);
      });

      // if the request is successful, it will display a success dialog
    } else {
      // Popup a dialog to show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in all the fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
