import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/add_todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/delete_todo.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/get_todos.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/update_todo.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/stores/todo_states.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/stores/todo_store.dart';

class MockGetTodoUsecase extends Mock implements GetTodoUsecase {}

class MockAddTodoUsecase extends Mock implements AddTodoUsecase {}

class MockUpdateTodoUsecase extends Mock implements UpdateTodoUsecase {}

class MockDeleteTodoUsecase extends Mock implements DeleteTodoUsecase {}

void main() {
  late MockGetTodoUsecase mockGetTodoUsecase;
  late MockAddTodoUsecase mockAddTodoUsecase;
  late MockUpdateTodoUsecase mockUpdateTodoUsecase;
  late MockDeleteTodoUsecase mockDeleteTodoUsecase;
  late ToDoStore store;

  setUp(() {
    mockGetTodoUsecase = MockGetTodoUsecase();
    mockAddTodoUsecase = MockAddTodoUsecase();
    mockUpdateTodoUsecase = MockUpdateTodoUsecase();
    mockDeleteTodoUsecase = MockDeleteTodoUsecase();

    store = ToDoStore(
      getTodoUsecase: mockGetTodoUsecase,
      addTodoUsecase: mockAddTodoUsecase,
      updateTodoUsecase: mockUpdateTodoUsecase,
      deleteTodoUsecase: mockDeleteTodoUsecase,
    );
  });

  group('ToDoStore test', () {
    final todo = ToDo(id: 1, description: 'Test Todo', completed: false);
    final todoList = [todo];

    test('should fetch all todos successfully', () async {
      when(() => mockGetTodoUsecase.getToDos())
          .thenAnswer((_) async => Success(todoList));

      await store.getAllToDos();

      expect(store.value, isA<SuccessToDoStoreState>());
      expect(store.tasksList.value, todoList);
    });

    test('should handle failure when fetching todos', () async {
      when(() => mockGetTodoUsecase.getToDos()).thenAnswer(
        (_) async => Failure(
          Exception('Error fetching todos'),
        ),
      );

      await store.getAllToDos();

      expect(store.value, isA<FailureToDoStoreState>());
    });

    test('should add a todo successfully', () async {
      when(() => mockAddTodoUsecase.call(todo)).thenAnswer(
        (_) async => Success(unit),
      );

      await store.addToDo(todo);

      expect(
        store.value,
        isA<SuccessToDoStoreState>(),
      );
    });

    test('should handle failure when adding a todo', () async {
      when(() => mockAddTodoUsecase.call(todo)).thenAnswer(
        (_) async => Failure(
          Exception(
            ('Error adding todo'),
          ),
        ),
      );

      await store.addToDo(todo);

      expect(store.value, isA<FailureToDoStoreState>());
    });

    test('should update a todo successfully', () async {
      when(() => mockUpdateTodoUsecase.call(todo)).thenAnswer((_) async => Success(unit));

      await store.updateToDo(todo);

      expect(store.value, isA<SuccessToDoStoreState>());
    });

    test('should handle failure when updating a todo', () async {
      when(() => mockUpdateTodoUsecase.call(todo))
          .thenAnswer((_) async => Failure(Exception('Error updating todo')));

      await store.updateToDo(todo);

      expect(store.value, isA<FailureToDoStoreState>());
    });

    test('should delete a todo successfully', () async {
      when(() => mockDeleteTodoUsecase.call(todo.id!))
          .thenAnswer((_) async => Success(unit));

      await store.deleteToDo(todo.id!);

      expect(store.value, isA<SuccessToDoStoreState>());
    });

    test('should handle failure when deleting a todo', () async {
      when(() => mockDeleteTodoUsecase.call(todo.id!))
          .thenAnswer((_) async => Failure(Exception('Error deleting todo')));

      await store.deleteToDo(todo.id!);

      expect(store.value, isA<FailureToDoStoreState>());
    });
  });
}
