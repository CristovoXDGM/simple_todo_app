import 'package:flutter/foundation.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/get_todos.dart';

import '../../../../core/util/todo_types.dart';
import 'todo_states.dart';

class GetTodoStore extends ValueNotifier<GetToDoStoreState> {
  GetTodoStore(this.getTodoUsecase) : super(InitalGetToDoStoreState());

  final GetTodoUsecase getTodoUsecase;

  final tasksList = ValueNotifier<ToDoList>([]);

  final notCompletedTaskList = ValueNotifier<ToDoList>([]);
  final completedTaskList = ValueNotifier<ToDoList>([]);

  void updateToDoList() {
    notCompletedTaskList.value = tasksList.value
        .where(
          (element) => element.completed == false,
        )
        .toList();

    completedTaskList.value = tasksList.value
        .where(
          (element) => element.completed == true,
        )
        .toList();
  }

  Future<void> getAllToDos() async {
    final result = await getTodoUsecase.getToDos();
    result.fold(
      (success) {
        tasksList.value = success;

        updateToDoList();

        value = SuccessGetToDoStoreState();
      },
      (failure) {
        debugPrint("Error: $failure");
        value = FailureGetToDoStoreState();
      },
    );
  }
}
