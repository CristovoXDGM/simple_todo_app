import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_local_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_remote_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/models/todo_model.dart';
import 'package:simple_simple_todo/src/features/todo/data/repositories/todo_repository_impl.dart';

class MockToDoRemoteDataSource extends Mock implements ToDoRemoteDataSource {}

class MockToDoLocalDataSource extends Mock implements ToDoLocalDataSource {}

void main() {
  late MockToDoRemoteDataSource mockRemoteDataSource;
  late MockToDoLocalDataSource mockLocalDataSource;
  late TodoRepositoryImpl repository;

  setUpAll(() {
    mockRemoteDataSource = MockToDoRemoteDataSource();
    mockLocalDataSource = MockToDoLocalDataSource();
    repository = TodoRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('addTodo', () {
    test('should return failure when an exception occurs', () async {
      final todo = ToDoModel(id: 1, description: 'Test Desc', completed: false);

      when(() => mockLocalDataSource.addTodo(todo)).thenThrow(Exception());

      final result = await repository.addTodo(todo);

      expect(result.isError(), true);
    });
  });

  group('deleteTodo', () {
    test('should delete a todo successfully', () async {
      const id = 1;

      when(() => mockLocalDataSource.deleteTodo(id)).thenAnswer((_) async {});

      final result = await repository.deleteTodo(id);

      expect(result.isSuccess(), true);
      verify(() => mockLocalDataSource.deleteTodo(id)).called(1);
    });

    test('should return failure when an exception occurs', () async {
      const id = 1;

      when(() => mockLocalDataSource.deleteTodo(id)).thenThrow(Exception());

      final result = await repository.deleteTodo(id);

      expect(result.isError(), true);
    });
  });

  group('getTodos', () {
    test('should return merged todos successfully', () async {
      final localTodos = [ToDoModel(id: 1, description: 'Local Desc')];
      final remoteTodos = [ToDoModel(id: 2, description: 'Remote Desc')];

      when(() => mockLocalDataSource.getTodos()).thenAnswer((_) async => localTodos);
      when(() => mockRemoteDataSource.fetchTodos()).thenAnswer((_) async => remoteTodos);
      when(() => mockLocalDataSource.cacheTodos(any())).thenAnswer((_) async {});

      final result = await repository.getTodos();

      expect(result.isSuccess(), true);
      expect(result.getOrNull()?.length, 2);
      verify(() => mockLocalDataSource.getTodos()).called(1);
      verify(() => mockRemoteDataSource.fetchTodos()).called(1);
      verify(() => mockLocalDataSource.cacheTodos(any())).called(1);
    });

    test('should return failure when an exception occurs', () async {
      when(() => mockLocalDataSource.getTodos()).thenThrow(Exception());

      final result = await repository.getTodos();

      expect(result.isError(), true);
    });
  });

  group('updateTodo', () {
    test('should return failure when an exception occurs', () async {
      final todo = ToDoModel(id: 1, description: 'Updated Desc');
      when(() => mockLocalDataSource.updateTodo(todo)).thenThrow(Exception());

      final result = await repository.updateTodo(todo);

      expect(result.isError(), true);
    });
  });
}
