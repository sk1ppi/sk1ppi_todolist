import 'package:flutter/material.dart';
import 'package:todolist/screens/todoAdd.dart';

class TodoLists extends StatefulWidget {
  const TodoLists({super.key});

  @override
  State<TodoLists> createState() => _TodoListsState();
}

class _TodoListsState extends State<TodoLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todolist'),
      ),

      // Action button to add a new task
      floatingActionButton: FloatingActionButton(
        onPressed: navigateTodoAddPage,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigateTodoAddPage() {
    final route = MaterialPageRoute(builder: (context) => const TodoAddPage());
    Navigator.push(context, route);
  }
}
