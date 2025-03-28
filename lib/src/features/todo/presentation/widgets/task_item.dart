import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/constants/app_colors.dart';
import 'package:simple_simple_todo/src/core/di/setup_dependecy_injection.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../stores/todo_store.dart';
import 'todo_details_modal.dart';

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
    var taskTextStyle = widget.todo.completed ? completedTaskStyle : taskStyle;

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.todo.completed ? AppColors.primaryColor : AppColors.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () {
              widget.todo.copyWith(completed: !widget.todo.completed);

              todoStore.updateToDo(
                widget.todo.copyWith(completed: !widget.todo.completed),
              );

              todoStore.getAllToDos();
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color:
                    widget.todo.completed ? AppColors.succesPrimarycolor : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Visibility(
                  visible: widget.todo.completed,
                  child: Icon(
                    Icons.check,
                    color: AppColors.successSecondaryColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      child: TodoDetailsModal(
                        todo: widget.todo,
                      ),
                    );
                  },
                );
              },
              child: Text(
                widget.todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: taskTextStyle,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
