// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:crud_sederhana_raden/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/models/pemasukan.dart';
import 'package:crud_sederhana_raden/services/pemasukan_service.dart';
import 'package:intl/intl.dart';

class PemasukanScreen extends StatefulWidget {
  @override
  _PemasukanScreenState createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pemasukanService = PemasukanService();

  TextEditingController _valuePemasukanController = TextEditingController();
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
        title: Text('Tambah Pemasukan'),
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
                controller: _valuePemasukanController,
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
                  final pemasukan = Pemasukan(
                    valuePemasukan:
                        int.tryParse(_valuePemasukanController.text) ?? 0,
                    description: _descriptionController.text,
                    date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                  );

                  _pemasukanService.insertPemasukan(pemasukan).then((result) {
                    if (result != null && result > 0) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
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
    _valuePemasukanController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
