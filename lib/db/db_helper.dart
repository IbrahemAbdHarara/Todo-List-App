import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_app/model/task_model.dart';
import 'dart:convert';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static Database? database;
  TaskModel taskModel = TaskModel();
  static const tableName = 'tasks';
  static const idColumnName = 'id';
  static const titleColumnName = 'title';
  static const noteColumnName = 'note';
  static const isCompletedColumnName = 'isCompleted';
  static const dateColumnName = 'date';
  static const startTimeColumnName = 'startTime';
  static const endTimeColumnName = 'endTime';
  static const colorColumnName = 'color';
  static const remindColumnName = 'remind';
  static const repeatColumnName = 'repeat';

  static final int _versoin = 1;
  static final String _tableNameDb = 'tasks';
  initDatabase() async {
    database = await creteConnectionWithDatabase();
  }

  Future<Database> creteConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'tasks.db';
    String fullPath = join(databasePath, databaseName);

    Database database = await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, i) {
        db.execute('''
  

  CREATE TABLE $tableName ($idColumnName INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumnName STRING,
   $noteColumnName TEXT, $dateColumnName STRING,
   $startTimeColumnName STRING, $endTimeColumnName STRING,
   $remindColumnName INTEGER, $repeatColumnName STRING,
   $isCompletedColumnName INTEGER, $colorColumnName INTEGER

   )

''');
      },
      onOpen: (db) {
        log("hello ,the database has been opend hi harara");
      },
    );
    return database;
  }

  // Future<Database> initDb() async {
  //   if (_database != null) {}
  //   try {
  //     String _path = await getDatabasesPath() + 'tasks.dp';
  //     _database = await openDatabase(
  //       _path,
  //       version: _versoin,
  //       onCreate: (db, i) {
  //         print('Creating a new one db');
  //         return db.execute(''' CREATE TABLE $_tableNameDb(
  //       id INTEGER PRIMARY KEY AUT,
  //       titel STRING, note TEXT, date STRING,
  //       startTime STRING, endTime STRING,
  //       remind INTEGER, repeat STRING,
  //       color INTEGER,
  //       isCompleted INTEGER)

  //       ''');
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  //   return;
  // }

  static Future<int> insert(TaskModel? taskModel) async {
    print('insert fun clled');
    return await database!.insert(_tableNameDb, taskModel!.toMap());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query fun called');
    return await database!.query(tableName);
  }

  static delete(TaskModel taskModel) async {
    await database!.delete(tableName, where: 'id=?', whereArgs: [taskModel.id]);
  }

  static update(int id) async {
    await database!.rawUpdate(
        '''UPDATE $tableName SET $isCompletedColumnName = ?WHERE $idColumnName = ?''',
        [1, id]);
  }
}
