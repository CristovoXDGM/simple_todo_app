import '../models/todo_model.dart';

abstract class ToDoLocalDataSource {
  Future<List<ToDoModel>> fetchTodos();
}

class ToDoLocalDataSourceImpl implements ToDoLocalDataSource {
  // final Dio client;

  ToDoLocalDataSourceImpl();

  @override
  Future<List<ToDoModel>> fetchTodos() async {
    throw Exception('Erro ao carregar tarefas');
    // final url = "https://dummyjson.com/todos";

    // final response = await client.get(url);

    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = response.data['todos'];
    //   return jsonData.map((todo) => ToDoModel.fromJson(todo)).toList();
    // } else {
    //   throw Exception('Erro ao carregar tarefas');
    // }
  }
}
