import 'package:flutter/material.dart';
import 'package:to_do_list/pages/widgets/todo_list_item.dart';

import '../models/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoIndex;

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hintText: "Ex: Estudar Flutter",
                        ),
                        controller: todoController,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String text = todoController.text;
                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              date: DateTime.now(),
                            );

                            todos.add(newTodo);
                          });
                          todoController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF00D7F3),
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        )),
                  ],
                ),
                const SizedBox(height: 8.0),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Você possui ${todos.length} tarefas pendentes",
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF00D7F3),
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text("Limpar tudo"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoIndex = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} removida com sucesso",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[300],
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.red[300],
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoIndex!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
