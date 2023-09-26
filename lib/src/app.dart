import 'package:crud_sederhana_raden/screens/login.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  //Disable banner debug pada flutter
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}