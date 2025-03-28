import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/core/util/todo_types.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../repositories/todo_repository.dart';

abstract class GetTodoUsecase {
  AsyncResult<ToDoList> getToDos();
  AsyncResult<ToDo> getSingleToDo(int todoId);
}

class GetTodoUsecaseImpl implements GetTodoUsecase {
  final ToDoRepository _repository;

  GetTodoUsecaseImpl(this._repository);

  @override
  AsyncResult<ToDoList> getToDos() async {
    final result = await _repository.getTodos();
    return result;
  }

  @override
  AsyncResult<ToDo> getSingleToDo(int todoId) {
    // TODO: implement getSingleToDo
    throw UnimplementedError();
  }
}
