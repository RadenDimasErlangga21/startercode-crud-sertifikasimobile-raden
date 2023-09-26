import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/src/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:crud_sederhana_raden/screens/login.dart'; // Import your Login screen
import 'package:crud_sederhana_raden/services/user_data_manager.dart';


//Routes pada Aplikasi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDataManager().initDatabase(); // Initialize the database
  // Initialize sqflite_common_ffi
  sqfliteFfiInit();

  runApp(App());
}
