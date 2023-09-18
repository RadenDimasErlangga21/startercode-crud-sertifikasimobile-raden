import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  //Disable banner debug pada flutter
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}