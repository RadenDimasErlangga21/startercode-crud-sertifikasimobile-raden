// ignore_for_file: unnecessary_import, depend_on_referenced_packages, avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseConnection {
  setDatabase() async {
    // Initialize sqflite_common_ffi
    sqfliteFfiInit();

    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_sqflite');
    
    print('Database location: $path'); // Add this line to print the location

    // Set the databaseFactory to use sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;

    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  // Table for categories
  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)");

    // Table for users
    await database.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)");

    // Table for pengeluaran
    await database.execute(
        "CREATE TABLE pengeluaran(id INTEGER PRIMARY KEY AUTOINCREMENT, value_pengeluaran INTEGER, description TEXT, date TEXT)");

    // Table for pemasukan
    await database.execute(
        "CREATE TABLE pemasukan(id INTEGER PRIMARY KEY AUTOINCREMENT, value_pemasukan INTEGER, description TEXT, date TEXT)");

    // Insert the user data
    await database.rawInsert(
        "INSERT INTO users (username, password) VALUES (?, ?)",
        ["user", "user"]);
  }
}
