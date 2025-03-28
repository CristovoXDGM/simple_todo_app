import 'package:flutter/foundation.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/add_todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/delete_todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/get_todos.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/update_todo.dart';

import '../../../../core/util/todo_types.dart';
import '../../domain/entities/todo.dart';
import 'todo_states.dart';

class GetTodoStore extends ValueNotifier<ToDoStoreState> {
  GetTodoStore({
    required this.getTodoUsecase,
    required this.addTodoUsecase,
    required this.updateTodoUsecase,
    required this.deleteTodoUsecase,
  }) : super(InitalToDoStoreStateState());

  final GetTodoUsecase getTodoUsecase;
  final AddTodoUsecase addTodoUsecase;
  final UpdateTodoUsecase updateTodoUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;

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

  Future<void> updateToDo(ToDo toDo) async {
    value = LoadingToDoStoreState();

    final result = await updateTodoUsecase.call(toDo);

    result.fold(
      (success) {
        updateToDoList();

        value = SuccessToDoStoreState();
      },
      (failure) {
        debugPrint("Error: $failure");
        value = FailureToDoStoreState();
      },
    );
  }

  Future<void> addToDo(ToDo toDo) async {
    value = LoadingToDoStoreState();

    final result = await addTodoUsecase.call(toDo);

    result.fold(
      (success) {
        updateToDoList();

        value = SuccessToDoStoreState();
      },
      (failure) {
        debugPrint("Error: $failure");
        value = FailureToDoStoreState();
      },
    );
  }

  Future<void> deleteToDo(int id) async {
    value = LoadingToDoStoreState();

    final result = await deleteTodoUsecase.call(id);

    result.fold(
      (success) {
        updateToDoList();

        value = SuccessToDoStoreState();
      },
      (failure) {
        debugPrint("Error: $failure");
        value = FailureToDoStoreState();
      },
    );
  }

  Future<void> getAllToDos() async {
    value = LoadingToDoStoreState();

    final result = await getTodoUsecase.getToDos();
    result.fold(
      (success) {
        tasksList.value = success;

        updateToDoList();

        value = SuccessToDoStoreState();
      },
      (failure) {
        debugPrint("Error: $failure");
        value = FailureToDoStoreState();
      },
    );
  }
}
