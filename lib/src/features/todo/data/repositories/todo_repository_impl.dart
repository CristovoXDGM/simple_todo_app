import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/core/util/todo_types.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_local_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_remote_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements ToDoRepository {
  TodoRepositoryImpl(this.remoteDataSource, this.localDataSource);
  final ToDoRemoteDataSource remoteDataSource;
  final ToDoLocalDataSource localDataSource;

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
  AsyncResult<ToDoList> getTodos() async {
    try {
      final remoteResult = await remoteDataSource.fetchTodos();

      final todoListRemote = remoteResult
          .map(
            (todo) => todo.toEntity(),
          )
          .toList();

      return Success(todoListRemote);
    } catch (e) {
      return Failure(
        Exception("Erro ao carregar tarefas"),
      );
    }
  }

  @override
  AsyncResult<void> updateTodo(ToDo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
