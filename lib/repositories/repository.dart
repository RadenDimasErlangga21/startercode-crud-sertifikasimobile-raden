import 'package:sqflite/sqflite.dart';
import 'package:crud_sederhana_raden/repositories/database_connection.dart';

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

  Future<int?> insertData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  Future<List<Map<String, dynamic>>?> readData(String table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  Future<List<Map<String, dynamic>>?> readDataById(String table, int itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id = ?', whereArgs: [itemId]);
  }

  Future<int?> updateData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int?> deleteData(String table, int itemId) async {
    var connection = await database;
    return await connection?.delete(table, where: 'id = ?', whereArgs: [itemId]);
  }
}
