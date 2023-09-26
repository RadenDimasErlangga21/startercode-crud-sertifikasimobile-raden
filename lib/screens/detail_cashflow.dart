// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/models/pengeluaran.dart';
import 'package:crud_sederhana_raden/models/pemasukan.dart';
import 'package:crud_sederhana_raden/services/pengeluaran_service.dart';
import 'package:crud_sederhana_raden/services/pemasukan_service.dart';

class DetailCashFlow extends StatefulWidget {
  @override
  _DetailCashFlowState createState() => _DetailCashFlowState();
}

class _DetailCashFlowState extends State<DetailCashFlow> {
  final PengeluaranService _pengeluaranService = PengeluaranService();
  final PemasukanService _pemasukanService = PemasukanService();

  // Define lists to store pengeluaran and pemasukan data
  List<Pengeluaran> pengeluaranList = [];
  List<Pemasukan> pemasukanList = [];

  // Fetch data from services when the widget initializes
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Fetch pengeluaran and pemasukan data
  Future<void> _fetchData() async {
    final pengeluaranData = await _pengeluaranService.getPengeluaranList();
    final pemasukanData = await _pemasukanService.getPemasukanList();

    setState(() {
      // Ensure data is correctly cast to List<Pengeluaran> and List<Pemasukan>
      pengeluaranList = (pengeluaranData ?? []).map((data) => Pengeluaran.fromMap(data)).toList();
      pemasukanList = (pemasukanData ?? []).map((data) => Pemasukan.fromMap(data)).toList();
      
      // Sort pengeluaranList and pemasukanList based on date in ascending order (oldest to newest)
      pengeluaranList.sort((a, b) => a.date.compareTo(b.date));
      pemasukanList.sort((a, b) => a.date.compareTo(b.date));
    });
  }

  // Build the UI with a ListView.builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Cash Flow'),
      ),
      body: ListView.builder(
        itemCount: pengeluaranList.length + pemasukanList.length,
        itemBuilder: (context, index) {
          if (index < pengeluaranList.length) {
            // Display pengeluaran data
            final pengeluaran = pengeluaranList[index];
            return Card(
              elevation: 4, // Add elevation effect
              child: ListTile(
                contentPadding: EdgeInsets.all(16), // Add padding
                leading: Icon(Icons.remove, color: Colors.red), // Minus icon on the left (red color)
                title: Text('Pengeluaran: ${pengeluaran.valuePengeluaran}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pengeluaran.description),
                    Text(pengeluaran.date, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.red), // Right arrow icon on the right (red color)
              ),
            );
          } else {
            // Display pemasukan data
            final pemasukan = pemasukanList[index - pengeluaranList.length];
            return Card(
              elevation: 4, // Add elevation effect
              child: ListTile(
                contentPadding: EdgeInsets.all(16), // Add padding
                leading: Icon(Icons.add, color: Colors.green), // Plus icon on the left (green color)
                title: Text('Pemasukan: ${pemasukan.valuePemasukan}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pemasukan.description),
                    Text(pemasukan.date, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                trailing: Icon(Icons.arrow_back, color: Colors.green), // Left arrow icon on the right (green color)
              ),
            );
          }
        },
      ),
    );
  }
}
