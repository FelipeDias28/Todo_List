import 'package:flutter/material.dart';
import 'package:to_do_list/pages/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todos = [];

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ocupa o maior espaço disponível da tela
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
                          todos.add(text);
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
                    for (String todo in todos) TodoListItem(),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Você possui 0 tarefas pendentes",
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
    );
  }
}
