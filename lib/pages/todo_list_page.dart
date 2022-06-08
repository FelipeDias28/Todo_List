import 'package:flutter/material.dart';
import 'package:to_do_list/pages/widgets/todo_list_item.dart';
import 'package:to_do_list/repositories/todo_repository.dart';

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
  final TodoRepository todoRepository = TodoRepository();
  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) => {
          setState(() {
            todos = value;
          })
        });
  }

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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          hintText: "Ex: Estudar Flutter",
                          errorText: errorText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00D7F3),
                              width: 2,
                            ),
                          ),
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

                          if (text.isEmpty) {
                            setState(() {
                              errorText = 'O título não pode ser vazio';
                            });

                            return;
                          }

                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              date: DateTime.now(),
                            );

                            todos.add(newTodo);
                            errorText = null;
                          });
                          todoController.clear();
                          todoRepository.saveTodoList(todos);
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
                      onPressed: showDeleteTodoConfirmationDialog,
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

    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} removida com sucesso",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[100],
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.red,
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

  void showDeleteTodoConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar Tudo?"),
        content:
            const Text("Você tem certeza que deseja apagar todas as tarefas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("cancelar"),
            style: TextButton.styleFrom(
              primary: const Color(0xFF00D7F3),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            child: const Text("Limpar Tudo"),
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });

    todoRepository.saveTodoList(todos);
  }
}
