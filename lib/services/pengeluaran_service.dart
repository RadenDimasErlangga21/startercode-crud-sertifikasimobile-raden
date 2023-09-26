import 'package:crud_sederhana_raden/models/pengeluaran.dart';
import 'package:crud_sederhana_raden/repositories/repository.dart';

class PengeluaranService {
  late Repository _repository;

  PengeluaranService() {
    _repository = Repository();
  }

  Future<int?> insertPengeluaran(Pengeluaran pengeluaran) async {
    return await _repository.insertData('pengeluaran', pengeluaran.toMap());
  }

  Future<List<Map<String, dynamic>>?> getPengeluaranList() async {
    return await _repository.readData('pengeluaran');
  }

  Future<List<Map<String, dynamic>>?> getPengeluaranById(int itemId) async {
    return await _repository.readDataById('pengeluaran', itemId);
  }

  Future<int?> updatePengeluaran(Pengeluaran pengeluaran) async {
    return await _repository.updateData('pengeluaran', pengeluaran.toMap());
  }

  Future<int?> deletePengeluaran(int itemId) async {
    return await _repository.deleteData('pengeluaran', itemId);
  }
}
