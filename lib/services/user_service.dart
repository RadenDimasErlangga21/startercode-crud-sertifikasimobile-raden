import 'package:crud_sederhana_raden/models/user.dart';
import 'package:crud_sederhana_raden/repositories/repository.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  Future<int?> insertUser(User user) async {
    return await _repository.insertData('users', user.toMap());
  }

  Future<List<Map<String, dynamic>>?> getUserList() async {
    return await _repository.readData('users');
  }

  Future<List<Map<String, dynamic>>?> getUserById(int itemId) async {
    return await _repository.readDataById('users', itemId);
  }

  Future<int?> updateUser(User user) async {
    return await _repository.updateData('users', user.toMap());
  }

  Future<int?> deleteUser(int itemId) async {
    return await _repository.deleteData('users', itemId);
  }
}
