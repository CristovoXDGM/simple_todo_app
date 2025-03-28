import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_simple_todo/src/features/todo/data/datasources/todo_remote_data_datasource.dart';

void main() {
  final dataSource = ToDoRemoteDataSourceImpl(
    client: Dio(),
  );
  test("description", () async {
    final result = await dataSource.fetchTodos();

    print(result);
  });
}
