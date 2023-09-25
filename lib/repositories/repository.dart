// ignore_for_file: unnecessary_null_comparison

import 'package:crud_sederhana_raden/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  // createdata
  Future<int?> insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  Future<List<Map<String, dynamic>>?> readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

readDataById(table, itemId) async {
  var connection = await database;
  return await connection?.query(table, where: 'id = ?', whereArgs: [itemId]);
}

  updateData(table, data) async{
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async{
    var connection = await database;
    return await connection?.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }
}
