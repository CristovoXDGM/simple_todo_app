import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/core/util/todo_types.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements ToDoRepository {
  @override
  AsyncResult<void> addTodo(ToDo todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  AsyncResult<ToDoList> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> updateTodo(ToDo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
