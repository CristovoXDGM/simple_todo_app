import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

class ToDoModel {
  final int? id;
  final String todo;

  final bool completed;

  ToDoModel({
    this.id,
    required this.todo,
    required this.completed,
  });

  ToDo toEntity() {
    return ToDo(
      id: id,
      todo: todo,
      completed: completed,
    );
  }

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
    };
  }
}
