import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

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
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adicione uma tarefa",
                        hintText: "Ex: Estudar Flutter",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  ElevatedButton(
                      onPressed: () {},
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
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: const Text("Tarefa 1"),
                    subtitle: const Text("20/11/2022"),
                    leading: const Icon(
                      Icons.save,
                      size: 30,
                    ),
                    onTap: () {
                      debugPrint("Tarefa 1");
                    },
                  ),
                  ListTile(
                    title: const Text("Tarefa 2"),
                    subtitle: const Text("21/11/2022"),
                    leading: const Icon(
                      Icons.person_add,
                      size: 30,
                    ),
                    onTap: () {
                      debugPrint("Tarefa 2");
                    },
                  )
                ],
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
