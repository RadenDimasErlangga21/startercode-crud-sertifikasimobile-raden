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
    
    // Set the databaseFactory to use sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;

    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  // Table for categories
  _onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)");
  }
}
