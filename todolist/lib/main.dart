import 'package:flutter/material.dart';
import 'package:todolist/screens/todoList.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todolist',
      theme: ThemeData.dark(),
      home: const TodoLists(),
    );
  }
}
