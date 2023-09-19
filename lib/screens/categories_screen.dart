// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields, non_constant_identifier_names, avoid_print

import 'package:crud_sederhana_raden/helpers/drawer_navigation.dart';
import 'package:crud_sederhana_raden/models/category.dart';
import 'package:crud_sederhana_raden/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

// Homescreen, bagian judul aplikasi
class _CategoriesScreenState extends State<CategoriesScreen> {
  // Inisialisasi dua controller untuk mengelola input teks
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  // Inisialisasi objek Category dan CategoryService
  var _category = Category();
  var _categoryService = CategoryService();

  // Inisialisasi list kategori
  List<Category> _categoryList = <Category>[];

  var category;

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Panggil method untuk mendapatkan semua kategori saat widget ini diinisialisasi
    getAllCategories();
  }

  getAllCategories() async {
    try {
      var categories = await _categoryService.readCategories();

      if (categories != null) {
        categories.forEach((category) {
          setState(() {
            var categoryModel = Category();
            categoryModel.name = category['name'];
            categoryModel.description = category['description'];
            print(
                'Category ID: ${category['id']}'); // Add this line to check the ID
            _categoryList.add(categoryModel);
          });
        });
      } else {
        print("Tidak ada kategori ditemukan");
      }
    } catch (e) {
      print("Kesalahan saat mengambil kategori: $e");
    }
  }

_editCategory(BuildContext context, int? categoryId) async {
  if (categoryId = null) {
    category = await _categoryService.readCategoryById(categoryId);
    if (category != null && category.isNotEmpty) {
      setState(() {
        _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
        _editCategoryDescriptionController.text =
            category[0]['description'] ?? 'No Description';
      });
      _EditFormDialog(context);
    } else {
      // Handle the case where the category is not found or an error occurs.
      print('Category not found for id: $categoryId');
      // Optionally, display an error message or take appropriate action.
    }
  } else {
    // Handle the case where categoryId is null or invalid
    print('Invalid categoryId: $categoryId');
    // Optionally, display an error message or take appropriate action
  }
}


  // Method untuk menampilkan dialog form tambah kategori
  _ShowFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            // Tombol Batal
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Batal'),
            ),
            // Tombol Simpan
            TextButton(
              onPressed: () async {
                // Mengambil data dari input teks
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;
                // Memanggil service untuk menyimpan kategori
                var result = await _categoryService.saveCategory(_category);
                print(result);

                // Menutup dialog form saat data berhasil disimpan
                Navigator.pop(context);

                // Menambahkan data ke daftar kategori
                setState(() {
                  _categoryList.add(_category);
                });

                // Mengosongkan input teks setelah data disimpan
                _categoryNameController.clear();
                _categoryDescriptionController.clear();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              child: Text('Simpan'),
            ),
          ],
          title: Text('Form Kategori'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Input teks untuk nama kategori
                TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Tulis Kategori',
                    labelText: 'Kategori',
                  ),
                ),
                // Input teks untuk deskripsi kategori
                TextField(
                  controller: _categoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Tulis Deskripsi Kategori',
                    labelText: 'Deskripsi Kategori',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method untuk menampilkan dialog form tambah kategori
  _EditFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            // Tombol Batal
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Batal'),
            ),
            // Tombol Simpan
            TextButton(
              onPressed: () async {
                // Mengambil data dari input teks
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;
                // Memanggil service untuk menyimpan kategori
                var result = await _categoryService.saveCategory(_category);
                print(result);

                // Menutup dialog form saat data berhasil disimpan
                Navigator.pop(context);

                // Menambahkan data ke daftar kategori
                setState(() {
                  _categoryList.add(_category);
                });
              },
              //update
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              child: Text('Update'),
            ),
          ],
          title: Text('Edit Form Kategori'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Input teks untuk nama kategori
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Tulis Kategori',
                    labelText: 'Kategori',
                  ),
                ),
                // Input teks untuk deskripsi kategori
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Tulis Deskripsi Kategori',
                    labelText: 'Deskripsi Kategori',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori'),
      ),
      // Menampilkan drawer navigation di samping aplikasi
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0, // Efek shadows (elevation)
              child: ListTile(
                title: Text(_categoryList[index].name),
                subtitle: Text(_categoryList[index]
                    .description), // menampilkan data description
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _editCategory(context, _categoryList[index].id);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Menampilkan dialog form tambah kategori saat tombol "+" ditekan
          _ShowFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
