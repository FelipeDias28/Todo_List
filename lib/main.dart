import 'package:flutter/material.dart';

import '../pages/todo_list_page.dart';

void main() {
  runApp(const MyApp()); // Hot Reload
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(), // Tela Inicial do aplicativo
      debugShowCheckedModeBanner: false,
    );
  }
}
