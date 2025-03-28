import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

abstract class ToDoLocalDataSource {
  Future<void> cacheTodos(List<ToDoModel> todos);
  Future<List<ToDoModel>> getTodos();
  Future<void> updateTodo(ToDoModel todo);
  Future<void> deleteTodo(int id);
  Future<void> addTodo(ToDoModel todo);
}

class ToDoLocalDataSourceImpl implements ToDoLocalDataSource {
  static const _tableName = 'toDos';
  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'toDo.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY,
            todo TEXT,
            completed INTEGER,
            isSynced INTEGER
          )
        ''');
      },
    );
    return _database!;
  }

  @override
  Future<void> cacheTodos(List<ToDoModel> todos) async {
    final db = await _db;
    final batch = db.batch();

    await db.delete(_tableName);
    final uniqueTodos = {for (var todo in todos) todo.id: todo}.values.toList();
    for (var todo in uniqueTodos) {
      if (todo.description.isNotEmpty) {
        batch.insert(
          _tableName,
          todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<ToDoModel>> getTodos() async {
    final db = await _db;
    final result = await db.query(_tableName);
    return result.map((map) => ToDoModel.fromMap(map)).toList();
  }

  @override
  Future<void> addTodo(ToDoModel todo) async {
    final db = await _db;
    await db.insert(
      _tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTodo(ToDoModel todo) async {
    final db = await _db;
    await db.update(
      _tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await _db;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
