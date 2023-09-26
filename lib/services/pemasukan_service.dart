import 'package:crud_sederhana_raden/models/pemasukan.dart';
import 'package:crud_sederhana_raden/repositories/repository.dart';

class PemasukanService {
  late Repository _repository;

  PemasukanService() {
    _repository = Repository();
  }

  Future<int?> insertPemasukan(Pemasukan pemasukan) async {
  return await _repository.insertData('pemasukan', pemasukan.toMap());
  }

  Future<List<Map<String, dynamic>>?> getPemasukanList() async {
    return await _repository.readData('pemasukan');
  }

  Future<List<Map<String, dynamic>>?> getPemasukanById(int itemId) async {
    return await _repository.readDataById('pemasukan', itemId);
  }

  Future<int?> updatePemasukan(Pemasukan pemasukan) async {
    return await _repository.updateData('pemasukan', pemasukan.toMap());
  }

  Future<int?> deletePemasukan(int itemId) async {
    return await _repository.deleteData('pemasukan', itemId);
  }
}
