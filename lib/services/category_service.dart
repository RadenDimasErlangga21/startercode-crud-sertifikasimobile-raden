import 'package:crud_sederhana_raden/models/category.dart';
import 'package:crud_sederhana_raden/repositories/repository.dart';

class CategoryService{

  late Repository _repository;
  CategoryService(){
    _repository = Repository();
  }

  saveCategory(Category category) async{
    return await _repository.insertData('categories', category.categoryMap());
  }
}