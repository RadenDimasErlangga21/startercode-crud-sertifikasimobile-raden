import 'package:crud_sederhana_raden/models/category.dart';
import 'package:crud_sederhana_raden/repositories/repository.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  // Membuat data kategori
  Future<int?> saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  // Membaca data kategori
  Future<List<Map<String, dynamic>>?> readCategories() async {
    // 'categories' adalah nama tabel yang berisi data kategori
    return await _repository.readData('categories');
  }

  //Membaca data dari id
  readCategoryById(categoryId) async{
    return await _repository.readDataById('categories', categoryId);
  }
}