// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'package:crud_sederhana_raden/helpers/drawer_navigation.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
 
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

//Homescreen, bagian judul aplikasi
class _CategoriesScreenState extends State<CategoriesScreen>{
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