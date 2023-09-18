import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/src/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


//Routes pada Aplikasi
void main() async {
  // Initialize sqflite_common_ffi
  sqfliteFfiInit();

  runApp(App());
}
