class ToDo {
  final int? id;

  final String description;
  final bool completed;

  ToDo({
    this.id,
    required this.description,
    this.completed = false,
  });

  ToDo copyWith({
    int? id,
    String? todo,
    bool? completed,
  }) {
    return ToDo(
      id: id ?? this.id,
      description: todo ?? description,
      completed: completed ?? this.completed,
    );
  }
}
