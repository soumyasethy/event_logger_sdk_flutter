import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:logger_sdk/LogModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const dbName = 'event.db';
const tableName = 'logs';
//Column Names
const entity_id = 'entity_id';
const event_name = 'event_name';
const value = 'value';
const event_ts = 'event_ts';
const status = 'status'; //"pending" or "success"

class Status {
  static int pending = 0;
  static int success = 1;
}

mixin DBHelper {
  Database _database;

  Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, int version) async {
        await db.execute(
          "CREATE TABLE $tableName($entity_id TEXT PRIMARY KEY, $event_name TEXT, $value TEXT, $event_ts INTEGER, $status INTEGER DEFAULT 0)",
        );
      },
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  Future<void> insertEvent(LoggerModel event) async {
    final Database db = await database;
    await db.insert(
      tableName,
      event.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LoggerModel>> getPendingEvents() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * from $tableName where $status==0 order by $event_ts DESC");
    return List.generate(maps.length, (i) {
      return LoggerModel.fromJson(maps[i]);
    });
  }

  Future<List<LoggerModel>> getSuccessEvents() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * from $tableName where $status==1 order by $event_ts DESC");
    return List.generate(maps.length, (i) {
      return LoggerModel.fromJson(maps[i]);
    });
  }

  Future<void> updateLoggerModel(LoggerModel event) async {
    final db = await database;
    await db.update(
      tableName,
      event.toJson(),
      where: "$entity_id = ?",
      whereArgs: [event.entityId],
    );
  }

  Future<void> deleteLoggerModel(String entityId) async {
    final db = await database;
    await db.delete(
      tableName,
      where: "$entityId = ?",
      whereArgs: [entityId],
    );
  }
}
