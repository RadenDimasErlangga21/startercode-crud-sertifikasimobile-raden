// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/models/pengeluaran.dart';
import 'package:crud_sederhana_raden/services/pengeluaran_service.dart';
import 'package:intl/intl.dart';

class PengeluaranScreen extends StatefulWidget {
  @override
  _PengeluaranScreenState createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pengeluaranService = PengeluaranService();

  TextEditingController _valuePengeluaranController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal :',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data tidak ada';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valuePengeluaranController,
                decoration: InputDecoration(labelText: 'Nominal :'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data tidak ada';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Keterangan :'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data tidak ada';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final pengeluaran = Pengeluaran(
                    valuePengeluaran: int.tryParse(_valuePengeluaranController.text) ?? 0,
                    description: _descriptionController.text,
                    date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                  );

                  _pengeluaranService.insertPengeluaran(pengeluaran).then((result) {
                    if (result != null && result > 0) {
                      Navigator.of(context).pop();
                    } else {
                      // Handle error
                    }
                  });
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _valuePengeluaranController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
