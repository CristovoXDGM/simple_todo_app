import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/core/util/todo_types.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_local_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_remote_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/models/todo_model.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements ToDoRepository {
  TodoRepositoryImpl(this.remoteDataSource, this.localDataSource);
  final ToDoRemoteDataSource remoteDataSource;
  final ToDoLocalDataSource localDataSource;

  @override
  AsyncResult<void> addTodo(ToDo todo) async {
    try {
      await localDataSource.addTodo(
        ToDoModel.toToDoModel(todo),
      );

      return Success(unit);
    } catch (e, s) {
      return Failure(
        Exception("Erro ao adicionar tarefa $e \n trace: $s"),
      );
    }
  }

  @override
  AsyncResult<void> deleteTodo(int id) async {
    try {
      await localDataSource.deleteTodo(id);
      return Success(unit);
    } catch (e) {
      return Failure(
        Exception("Erro ao deletar tarefa"),
      );
    }
  }

  @override
  AsyncResult<ToDoList> getTodos() async {
    try {
      final localResult = await localDataSource.getTodos();

      final remoteResult = await remoteDataSource.fetchTodos();

      final mergedToDoModel = [
        ...remoteResult,
        ...localResult.where(
          (localTodo) => !remoteResult.any(
            (remoteTodo) => remoteTodo.id == localTodo.id,
          ),
        ),
      ];

      await localDataSource.cacheTodos(mergedToDoModel);

      if (localResult.isEmpty) {
        final remoteToDoList = remoteResult
            .map(
              (todo) => todo.toEntity(),
            )
            .toList();
        await localDataSource.cacheTodos(remoteResult);

        return Success(remoteToDoList);
      }

      final mergedTodoList = localResult
          .map(
            (todo) => todo.toEntity(),
          )
          .toList()
        ..addAll(
          remoteResult
              .where(
                (remoteTodo) =>
                    !localResult.any((localTodo) => localTodo.id == remoteTodo.id),
              )
              .map((todo) => todo.toEntity()),
        );

      return Success(mergedTodoList);
    } catch (e, s) {
      return Failure(
        Exception("Erro ao carregar tarefas $e \n trace: $s "),
      );
    }
  }

  @override
  AsyncResult<void> updateTodo(ToDo todo) async {
    try {
      await localDataSource.updateTodo(
        ToDoModel.toToDoModel(todo),
      );

      return Success(unit);
    } catch (e, s) {
      return Failure(
        Exception("Erro ao atualizar tarefa $e \n trace: $s"),
      );
    }
  }
}
