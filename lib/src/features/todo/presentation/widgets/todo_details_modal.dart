import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_simple_todo/src/core/constants/app_colors.dart';
import 'package:simple_simple_todo/src/core/constants/app_text_styles.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../../../../core/di/setup_dependecy_injection.dart';
import '../stores/todo_store.dart';

class TodoDetailsModal extends StatefulWidget {
  const TodoDetailsModal({super.key, required this.todo});
  final ToDo todo;
  @override
  State<TodoDetailsModal> createState() => _TodoDetailsModalState();
}

class _TodoDetailsModalState extends State<TodoDetailsModal> {
  final todoStore = getIt.get<ToDoStore>();
  final todoTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    todoTextController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(color: AppColors.backgroundColor),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  todoStore.updateToDo(
                    widget.todo.copyWith(completed: !widget.todo.completed),
                  );
                  todoStore.getAllToDos();
                  context.pop();
                },
                icon: Row(
                  children: [
                    Icon(
                      widget.todo.completed ? Icons.undo : Icons.check,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.todo.completed ? 'Desfazer' : 'Concluir',
                      style: taskStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.close,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Cancelar',
                      style: taskStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: sizer.width,
            child: TextField(
              style: taskStyle,
              controller: todoTextController,
              decoration: InputDecoration(
                hintText: widget.todo.description,
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.primaryColor,
                hintStyle: hintStyle,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                  todoStore.deleteToDo(
                    widget.todo.id!,
                  );
                  todoStore.getAllToDos();
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Apagar',
                      style: taskStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                  todoStore.updateToDo(
                    widget.todo.copyWith(todo: todoTextController.text),
                  );
                  todoStore.getAllToDos();
                },
                icon: Row(
                  children: [
                    Icon(
                      Icons.save,
                      color: AppColors.textColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Salvar',
                      style: taskStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
