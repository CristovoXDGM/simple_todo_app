import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/util/todo_types.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/widgets/task_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key, required this.toDos});

  final ToDoList toDos;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.toDos.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TaskItem(
          index: index,
          todo: widget.toDos[index],
        );
      },
    );
  }
}
