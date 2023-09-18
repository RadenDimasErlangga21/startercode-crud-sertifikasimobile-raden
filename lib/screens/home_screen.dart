// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:crud_sederhana_raden/helpers/drawer_navigation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//Homescreen, bagian judul aplikasi
class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD Sederhana'),
        ),
        //menampilkan navbar pada bagian samping applikasi 
        drawer: DrawerNavigation(),
    );
  }
}