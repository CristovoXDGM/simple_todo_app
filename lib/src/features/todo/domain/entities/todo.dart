class ToDo {
  final int? id;

  final String todo;
  final bool completed;

  ToDo({
    this.id,
    required this.todo,
    required this.completed,
  });

  ToDo copyWith({
    int? id,
    String? todo,
    bool? completed,
  }) {
    return ToDo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
    );
  }
}
