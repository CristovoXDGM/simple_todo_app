import 'package:result_dart/result_dart.dart';

import '../repositories/todo_repository.dart';

abstract class DeleteTodoUsecase {
  AsyncResult<void> call(int id);
}

class DeleteTodoUsecaseImpl implements DeleteTodoUsecase {
  final ToDoRepository _repository;

  DeleteTodoUsecaseImpl(this._repository);

  @override
  AsyncResult<void> call(int id) async {
    final result = await _repository.deleteTodo(id);
    return result;
  }
}
