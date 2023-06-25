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
