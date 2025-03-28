import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';

abstract class ToDoRemoteDataSource {
  Future<List<ToDoModel>> fetchTodos();
}

class ToDoRemoteDataSourceImpl implements ToDoRemoteDataSource {
  final Dio client;

  ToDoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ToDoModel>> fetchTodos() async {
    final url = "https://dummyjson.com/todos";

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data['todos'];
      return jsonData.map((todo) => ToDoModel.fromMap(todo)).toList();
    } else {
      debugPrint("Error fetching todos: ${response.statusCode}");
      return [];
    }
  }
}
