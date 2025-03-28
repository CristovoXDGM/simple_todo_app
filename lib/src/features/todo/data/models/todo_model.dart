import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';

class ToDoModel extends ToDo {
  final bool isSynced;

  ToDoModel({
    super.id,
    required super.description,
    super.completed,
    this.isSynced = false,
  });

  ToDo toEntity() {
    return ToDo(
      id: id,
      description: description,
      completed: completed,
    );
  }

  ToDoModel copyWithModel({bool? isSynced}) {
    return ToDoModel(
      id: id,
      description: description,
      completed: completed,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  static ToDoModel toToDoModel(ToDo todo) {
    return ToDoModel(
      description: todo.description,
      completed: todo.completed,
      id: todo.id,
    );
  }

  static bool _isBoolOrNumber(dynamic value) {
    if (value is bool) {
      return value;
    } else {
      return value == 1;
    }
  }

  factory ToDoModel.fromMap(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
      description: json['todo'] ?? '',
      completed: _isBoolOrNumber(json['completed']),
      isSynced: _isBoolOrNumber(json['isSynced']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': description,
      'completed': completed ? 1 : 0,
      'isSynced': isSynced ? 1 : 0,
    };
  }
}
