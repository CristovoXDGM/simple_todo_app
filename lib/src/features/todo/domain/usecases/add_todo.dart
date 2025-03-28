import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../repositories/todo_repository.dart';

abstract class AddTodoUsecase {
  AsyncResult<void> call(ToDo todo);
}

class AddTodoUsecaseImpl implements AddTodoUsecase {
  final ToDoRepository _repository;

  AddTodoUsecaseImpl(this._repository);

  @override
  AsyncResult<void> call(ToDo todo) async {
    if (todo.description.isEmpty) {
      return Failure(
        Exception("Description cannot be empty"),
      );
    }
    final result = await _repository.addTodo(todo);
    return result;
  }
}
