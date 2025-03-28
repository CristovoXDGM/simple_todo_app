import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/di/setup_dependecy_injection.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../stores/todo_store.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.index, required this.todo});
  final int index;
  final ToDo todo;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final todoStore = getIt.get<GetTodoStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        todoStore.tasksList.value[widget.index] =
            widget.todo.copyWith(completed: !widget.todo.completed);

        todoStore.updateToDoList();
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 18,
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: widget.todo.completed ? Colors.green.shade300 : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Visibility(
                  visible: widget.todo.completed,
                  child: Icon(
                    Icons.check,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                widget.todo.todo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: widget.todo.completed ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Icon(Icons.calendar_month),
                Text('fake'),
              ],
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
