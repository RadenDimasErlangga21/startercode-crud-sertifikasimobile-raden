// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields, non_constant_identifier_names, avoid_print

import 'package:crud_sederhana_raden/helpers/drawer_navigation.dart';
import 'package:crud_sederhana_raden/models/category.dart';
import 'package:crud_sederhana_raden/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
 
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

//Homescreen, bagian judul aplikasi
class _CategoriesScreenState extends State<CategoriesScreen>{
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService =  CategoryService();

  _ShowFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          TextButton(
          onPressed: () =>Navigator.pop(context),
          style: TextButton.styleFrom(
          foregroundColor: Colors.red,
        ),
          child: Text('Batal'),
          ),

          TextButton(
          onPressed: () async{
            _category.name = _categoryNameController.text;
            _category.description = _categoryDescriptionController.text;
            var result = await _categoryService.saveCategory(_category);
            print(result);

          },
          style: TextButton.styleFrom(
          foregroundColor: Colors.blue
          ,
        ),
          child: Text('Simpan'),
          )
          
        ],
        title: Text('Form Kategori'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  hintText: 'Tulis Kategori', 
                  labelText: 'Kategori'
                ),
              ),

                TextField(
                controller: _categoryDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Tulis Deskripsi Kategori', 
                  labelText: 'Deskripsi Kategori'
                ),
              ),
            ],
          )
          ),
      );
    });
  
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori'),
        ),
        //menampilkan navbar pada bagian samping applikasi 
        drawer: DrawerNavigation(),
        body: Center(child: Text('Test')), 
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _ShowFormDialog(context);
            }, 
        child: Icon(Icons.add)),
    );
  }
}