import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

import '../repositories/todo_repository.dart';

abstract class GetTodoUsecase {
  AsyncResult<void> call(ToDo todo);
}

class GetTodoUsecaseImpl implements GetTodoUsecase {
  final ToDoRepository _repository;

  GetTodoUsecaseImpl(this._repository);

  @override
  AsyncResult<void> call(ToDo todo) async {
    final result = await _repository.getTodos();
    return result;
  }
}
