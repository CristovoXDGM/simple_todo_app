import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/core/util/todo_types.dart';

import '../entities/todo.dart';

abstract class ToDoRepository {
  AsyncResult<ToDoList> getTodos();
  AsyncResult<void> addTodo(ToDo todo);
  AsyncResult<void> updateTodo(ToDo todo);

  AsyncResult<void> deleteTodo(int id);
}
