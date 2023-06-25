# riverpod_todo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Todos Tile with switcher
<img width="513" alt="image" src="https://github.com/YamamotoDesu/riverpod_todo/assets/47273077/466c3c59-52b4-4fa1-859a-d315dbdfee72">

## Riverpod

<img width="513" alt="image" src="https://github.com/YamamotoDesu/riverpod_todo/assets/47273077/93dbbd53-0f59-41d7-9113-b0fa6681088e">

## Sqflite

lib/common/helpers/db_helper.dart
```dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/task_model.dart';

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      "CREATE TABLE todos("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "title STRING, desc Text, date STRING,"
      "startTime STRING, endTime STRING,"
      "remind INTEGER, repeat INTEGER, "
      "isCompleted INTEGER)",
    );

    await database.execute(
      "CREATE TABLE user("
      "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,"
      "isVerified INTEGER)",
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbestech',
      version: 1,
      onCreate: (sql.Database databse, int version) async {
        await createTables(databse);
      },
    );
  }

  static Future<int> createItem(Task task) async {
    final db = await DBHelper.db();
    final id = db.insert(
      'todos',
      task.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DBHelper.db();

    final data = {
      'id': 1,
      'isVerified': isVerified,
    };

    final id = await db.insert(
      'user',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();
    return db.query(
      'todos',
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
  }

  static Future<int> updateItem(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startItem,
    String endTime,
  ) async {
    final db = await DBHelper.db();

    final data = {
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startItem,
      'endTime': endTime,
    };

    final results =
        await db.update('todos', data, where: "id = ?", whereArgs: [id]);

    return results;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();

    try {
      db.delete('todos', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Unable to delete: $e");
    }
  }
}
```

lib/common/models/task_model.dart
```dart
import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  int? id;
  String? title;
  String? desc;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'isCompleted': isCompleted,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'repeat': repeat,
      };
}
```
