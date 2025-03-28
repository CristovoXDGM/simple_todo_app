import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_local_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_remote_data_datasource.dart';
import 'package:simple_simple_todo/src/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:simple_simple_todo/src/features/todo/domain/usecases/get_todos.dart';

import '../../features/todo/presentation/stores/todo_store.dart';

final getIt = GetIt.instance;

class SetupDependecyInjection {
  void setup() {
    getIt.registerLazySingleton<ToDoRemoteDataSource>(
      () => ToDoRemoteDataSourceImpl(
        client: Dio(),
      ),
    );
    getIt.registerLazySingleton<ToDoLocalDataSource>(
      () => ToDoLocalDataSourceImpl(),
    );
    getIt.registerFactory(
      () => TodoRepositoryImpl(
        getIt.get<ToDoRemoteDataSource>(),
        getIt.get<ToDoLocalDataSource>(),
      ),
    );

    getIt.registerFactory<GetTodoUsecase>(
      () => GetTodoUsecaseImpl(
        getIt.get<TodoRepositoryImpl>(),
      ),
    );
    getIt.registerLazySingleton<GetTodoStore>(
      () => GetTodoStore(
        getIt.get<GetTodoUsecase>(),
      ),
    );
  }
}
