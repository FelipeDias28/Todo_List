import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(todo.date),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actionPane: const SlidableDrawerActionPane(), // Modo de deslizar
        secondaryActions: [
          // botões que a aparece se deslizar para a direita
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: "Deletar",
            onTap: () {
              onDelete(todo);
            },
          )
        ],
        actionExtentRatio: 0.25,
      ),
    );
  }
}
