// ignore_for_file: unnecessary_null_comparison, unnecessary_import, depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UserDataManager {
  static final UserDataManager _instance = UserDataManager._internal();
  factory UserDataManager() {
    return _instance;
  }

  UserDataManager._internal();

  late Database _database;

  Future<void> initDatabase() async {
    // Set the databaseFactory to databaseFactoryFfi
    databaseFactory = databaseFactoryFfi;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'userdata.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE user_data (
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');

        await db.insert(
          'user_data',
          {
            'username': 'user',
            'password': 'user',
          },
        );
      },
    );
  }

  Future<Map<String, String>?> getUserData() async {
    if (_database == null) {
      await initDatabase();
    }

    final results = await _database.query('user_data');
    if (results.isNotEmpty) {
      final userData = results.first;
      return {
        'username': userData['username'] as String,
        'password': userData['password'] as String,
      };
    }
    return null;
  }
}
