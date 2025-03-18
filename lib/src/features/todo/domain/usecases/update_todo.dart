import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../repositories/todo_repository.dart';

abstract class UpdateTodoUsecase {
  AsyncResult<void> call(ToDo todo);
}

class UpdateTodoUsecaseImpl implements UpdateTodoUsecase {
  final ToDoRepository _repository;

  UpdateTodoUsecaseImpl(this._repository);

  @override
  AsyncResult<void> call(ToDo todo) async {
    final result = await _repository.updateTodo(todo);
    return result;
  }
}
